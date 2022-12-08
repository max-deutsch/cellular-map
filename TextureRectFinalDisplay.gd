extends TextureRect

onready var Sprite1 = $"/root/RootControl/Viewport1/Sprite1"
onready var Sprite2 = $"/root/RootControl/Viewport2/Sprite2"
onready var UIContainer = $"/root/RootControl/UIContainer"
onready var ClickThresholdInput = $"/root/RootControl/UIContainer/HBoxContainer/ClickThresholdInput"
onready var TreeProbInput = $"/root/RootControl/UIContainer/HBoxContainer/TreeProbInput"
onready var FireProbInput = $"/root/RootControl/UIContainer/HBoxContainer/FireProbInput"
onready var TargetFPSInput = $"/root/RootControl/UIContainer/HBoxContainer/TargetFPSInput"
onready var Time1Step = $"/root/RootControl/UIContainer/HBoxContainer/Time1Step"
onready var Time10Step = $"/root/RootControl/UIContainer/HBoxContainer/Time10Step"
onready var Time100Step = $"/root/RootControl/UIContainer/HBoxContainer/Time100Step"
onready var Time1000Step = $"/root/RootControl/UIContainer/HBoxContainer/Time1000Step"
onready var Time10000Step = $"/root/RootControl/UIContainer/HBoxContainer/Time10000Step"

var ms1step = 0
var ms10step = 0
var ms100step = 0
var ms1000step = 0
var ms10000step = 0

var ms1step_display = -1
var ms10step_display = -1
var ms100step_display = -1
var ms1000step_display = -1
var ms10000step_display = -1

var frameCount = 0
var valid_mouse_pos: bool

func _ready():
	ClickThresholdInput.connect("value_changed", self, "on_click_threshold_change")
	TreeProbInput.connect("value_changed", self, "on_tree_prob_change")
	FireProbInput.connect("value_changed", self, "on_fire_prob_change")
	TargetFPSInput.connect("value_changed", self, "on_target_fps_change")
	
	ClickThresholdInput.set_value(1.0);
	TreeProbInput.set_value(0.0);
	FireProbInput.set_value(0.0);
	TargetFPSInput.set_value(0.0);

func on_click_threshold_change(value):
	Sprite1.material.set_shader_param("click_threshold", value)

func on_tree_prob_change(value):
	Sprite1.material.set_shader_param("treeProbability", value / 100.0)
	Sprite2.material.set_shader_param("treeProbability", value / 100.0)
	
func on_fire_prob_change(value):
	Sprite1.material.set_shader_param("fireProbability", value / 100.0)
	Sprite2.material.set_shader_param("fireProbability", value / 100.0)
	
func on_target_fps_change(value):
	Engine.set_target_fps(value)
	ms1step_display = -1
	ms10step_display = -1
	ms100step_display = -1
	ms1000step_display = -1
	ms10000step_display = -1

func _input(event: InputEvent):
	if not event is InputEventMouse:
		return

	if not Sprite1:
		print("Could not mount Sprite1")
		return

	if event is InputEventMouseButton:
		if valid_mouse_pos:
			Sprite1.material.set_shader_param("mouse_pressed", event.pressed)
			Sprite1.material.set_shader_param("mouse_button_index", event.button_index)

	if event is InputEventMouseMotion:
		var pos = event.position		
		var ui_rect: Rect2 = UIContainer.get_rect()
		valid_mouse_pos  = not ui_rect.has_point(pos)
		Sprite1.material.set_shader_param("mouse_position", pos)

func _process(delta):
	ms1step = delta * 1000
	ms1step_display = ms1step
	frameCount += 1
	if frameCount % 10 == 0:
		ms10step_display = ms10step
		ms10step = 0
	ms10step += delta * 1000
	
	if frameCount % 100 == 0:
		ms100step_display = ms100step
		ms100step = 0
	ms100step += delta * 1000
	
	if frameCount % 1000 == 0:
		ms1000step_display = ms1000step
		ms1000step = 0
	ms1000step += delta * 1000
	
	if frameCount % 10000 == 0:
		ms10000step_display = ms10000step
		ms10000step = 0
	ms10000step += delta * 1000
	
func _physics_process(_delta):
	Time1Step.set_text(str(ms1step_display))
	Time10Step.set_text(str(ms10step_display))
	Time100Step.set_text(str(ms100step_display))
	Time1000Step.set_text(str(ms1000step_display))
	Time10000Step.set_text(str(ms10000step_display))
