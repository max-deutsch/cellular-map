shader_type canvas_item;

const float fireProbability = 0.00;
const float treeProbability = 0.05;

const vec4 empty = vec4(0.0, 0.0, 0.0, 1.0);
const vec4 fire = vec4(1.0, 0.0, 0.0, 1.0);
const vec4 tree = vec4(0.0, 1.0, 0.0, 1.0);

const vec2 top_left_offset = vec2(-1.0, -1.0);
const vec2 top_middle_offset = vec2(0.0, -1.0);
const vec2 top_right_offset = vec2(1.0, -1.0);
const vec2 center_left_offset = vec2(-1.0, 0.0);
const vec2 center_right_offset = vec2(1.0, 0.0);
const vec2 bottom_left_offset = vec2(-1.0, 1.0);
const vec2 bottom_middle_offset = vec2(0.0, 1.0);
const vec2 bottom_right_offset = vec2(1.0, 1.0);

// https://godotshaders.com/snippet/random-value/
float random (vec2 uv) {
    return fract(sin(dot(uv.xy * TIME,
        vec2(12.9898,78.233))) * 43758.5453123);
}


void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 sz = SCREEN_PIXEL_SIZE;
	
	
	
	vec4 cell = texture(TEXTURE, SCREEN_UV);
	
	vec4 result = cell;
	if(cell == fire) {
		// A cell with a burning tree will become empty
		result = empty;
	} else if (cell == tree) {		
		const vec4 state = fire;
		int neighbourFireCount = 
			(texture(TEXTURE, SCREEN_UV + top_left_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + top_middle_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + top_right_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + center_left_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + center_right_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + bottom_left_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + bottom_middle_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0) +
			(texture(TEXTURE, SCREEN_UV + bottom_right_offset * SCREEN_PIXEL_SIZE) == state ? 1 : 0);
		
		// A cell containing a tree will catch on fire, if at least one neighbor is on fire
		// A cell containing a tree without a neighbor on fire will catch fire with a probability
		if(neighbourFireCount > 0) {
			result = fire;
		} else if(random(uv) <= fireProbability) {
			result = fire;
		}
	} else if(random(uv) <= treeProbability) {
		// An empty cell will grow a new tree with a probability
		result = tree;
	}
	
	COLOR = result;
}