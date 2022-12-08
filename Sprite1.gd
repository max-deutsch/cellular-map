extends Sprite

func _ready():
	self.texture = $"../../Viewport2".get_texture()	
	self.texture.set_flags(self.texture.flags | Texture.FLAG_REPEAT)
#	print("self.texture.flags %d" % (self.texture.flags))
#	print("self.texture.flags & Texture.FLAG_REPEAT %d" % (self.texture.flags & Texture.FLAG_REPEAT))
#	print("Texture.FLAG_REPEAT %d" % Texture.FLAG_REPEAT)
