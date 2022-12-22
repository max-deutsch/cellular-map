extends HBoxContainer

onready var createMapButton = $"CreateMapButton"
onready var map = $"../MapViewportContainer/Viewport/Map"
onready var mapGen = $"../MapGenViewportContainer/Viewport/RootControl"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	createMapButton.connect("pressed", self, "on_create_map")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_create_map():
	print("on_create_map")
	var texture: Texture = mapGen.getTexture()
	map.fillFromTexture(texture)
	
