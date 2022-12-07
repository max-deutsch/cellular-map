shader_type canvas_item;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 sz = SCREEN_PIXEL_SIZE;
	
	COLOR = vec4(uv, 0.0, 1.0);
}