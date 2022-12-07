extends TextureRect

onready var Sprite1 = $"/root/RootControl/Viewport1/Sprite1"

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
