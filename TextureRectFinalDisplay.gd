extends TextureRect

onready var Sprite1 = $"/root/RootControl/Viewport1/Sprite1"
onready var Sprite2 = $"/root/RootControl/Viewport2/Sprite2"
onready var TreeProbInput = $"/root/RootControl/UIContainer/HBoxContainer/TreeProbInput"

func _ready():
	TreeProbInput.connect("value_changed", self, "on_tree_prob_change")

func on_tree_prob_change(value):
	Sprite1.material.set_shader_param("treeProbability", value/100.0)
	

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
