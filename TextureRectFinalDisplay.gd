extends TextureRect

onready var Sprite1 = $"/root/RootControl/Viewport1/Sprite1"
onready var Sprite2 = $"/root/RootControl/Viewport2/Sprite2"
onready var TreeProbInput = $"/root/RootControl/UIContainer/HBoxContainer/TreeProbInput"
onready var FireProbInput = $"/root/RootControl/UIContainer/HBoxContainer/FireProbInput"
onready var TargetFPSInput = $"/root/RootControl/UIContainer/HBoxContainer/TargetFPSInput"
onready var Time1Step = $"/root/RootControl/UIContainer/HBoxContainer/Time1Step"

var ms1step = -1
var ms10steps = -1
var ms100steps = -1
var ms1000steps = -1
var ms10000steps = -1

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
	
func _physics_process(delta):
	Time1Step.set_text("1 Step: %fms" % ms1step)
