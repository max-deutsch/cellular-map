extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fillFromTexture(texture: Texture):
	print("fillFromTexture")
	var image: Image = texture.get_data()
	# self.clear()
	image.lock()
	for x in image.get_width():
		for y in image.get_height():			
			var col: Color = image.get_pixel(x, y)
			var tile: int = -1
			if col.r > 0:
				tile = 0
			elif col.g > 0:
				tile = 1
			elif col.b > 0:
				tile = 2				
			self.set_cell(x, y, tile)
	image.unlock()

# RGB 
# Red
# Green
# Blue

# Tiles
# 0 Food
# 1 Land
# 2 Water
# 3 Eaten Food
