extends TextureRect

onready var Sprite1 = $"/root/RootControl/Viewport1/Sprite1"
onready var Sprite2 = $"/root/RootControl/Viewport2/Sprite2"
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
var frameCount = 0

func _ready():
	TreeProbInput.connect("value_changed", self, "on_tree_prob_change")
	FireProbInput.connect("value_changed", self, "on_fire_prob_change")
	TargetFPSInput.connect("value_changed", self, "on_target_fps_change")
	
	TreeProbInput.set_value(0.5);
	FireProbInput.set_value(0.0);
	TargetFPSInput.set_value(0.0);

func on_tree_prob_change(value):
	Sprite1.material.set_shader_param("treeProbability", value / 100.0)
	Sprite2.material.set_shader_param("treeProbability", value / 100.0)
	
func on_fire_prob_change(value):
	Sprite1.material.set_shader_param("fireProbability", value / 100.0)
	Sprite2.material.set_shader_param("fireProbability", value / 100.0)
	
func on_target_fps_change(value):
	Engine.set_target_fps(value)

func _input(event: InputEvent):
	if not event is InputEventMouse:
		return

	if not Sprite1:
		print("Could not mount Sprite1")
		return

	if event is InputEventMouseButton:
		Sprite1.material.set_shader_param("mouse_pressed", event.pressed)

	if event is InputEventMouseMotion:
		var pos = event.position

		Sprite1.material.set_shader_param("mouse_position", pos)

func _process(delta):
	ms1step = delta * 1000
	++frameCount
	if frameCount % 10 == 0:
		ms10step = 0
	ms10step += delta * 1000
	
	if frameCount % 100 == 0:
		ms100step = 0
	ms100step += delta * 1000
	
	if frameCount % 1000 == 0:
		ms1000step = 0
	ms1000step += delta * 1000
	
	if frameCount % 10000 == 0:
		ms10000step = 0
	ms10000step += delta * 1000
	
func _physics_process(delta):
	Time1Step.set_text("%fms" % ms1step)
	Time10Step.set_text("%fms" % ms10step)
	Time100Step.set_text("%fms" % ms100step)
	Time1000Step.set_text("%fms" % ms1000step)
	Time10000Step.set_text("%fms" % ms10000step)
