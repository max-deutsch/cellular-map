# TODOs
- [ ] Ensure Viewports have same size
- [ ] Make viewports resizable
- [ ] Why are the Sprites (Renderer) scaled with 2?
- [x] How is the FinalDisplay's texture set to that of Viewport2?
  - [x] -> View the interface. Texture. A ViewportTexture
- [ ] Where Viewport.gd used?
  - [ ] Maybe it is not used. The same functionality is called in the Root Control's script


# Docu
Each Sprite has a script attached which sets the Sprite's texture to that from the other Sprite. This should ensure alternate rendering of the scene. First both have the same initial blank texture state.
InputArea.gd is attached to the TextureRect FinalDisplay which handles the input an passes it to the first Sprite's Shader to start the process. 

Is this setup usable for forest fire?
The problem is the probabiliteis they use.
But it must work because they do alternate.

Both Sprites (Renderer) have the Shader attached which does the calculation.
The TextureRect (FinalDisplay) has the Shader attached to display the final image. It can include effects using the current display

A viewport is used for sub-views. Children render to it. Viewports don't share what they draw.

The Root Control Node's anchor is set to fill the whole display.

Window size is set to the project settings. The Viewports sizees matter

TextureRectFinalDisplay's Anchor are set to fill the window

A ShaderMaterial is set to both Sprites

The start color must be transparent. 

# Shader
shader type canvas_item
https://docs.godotengine.org/en/stable/tutorials/shaders/shader_reference/canvas_item_shader.html#doc-canvas-item-shader


const vec4 top_left_offset = vec2(-1.0, -1.0);
const vec4 top_middle_offset = vec2(0.0, -1.0);
const vec4 top_right_offset = vec2(1.0, -1.0);
const vec4 center_left_offset = vec2(-1.0, 0.0);
const vec4 center_right_offset = vec2(1.0, 0.0);
const vec4 bottom_left_offset = vec2(-1.0, 1.0);
const vec4 bottom_middle_offset = vec2(0.0, 1.0);
const vec4 bottom_right_offset = vec2(1.0, 1.0);

# Randomness

// https://stackoverflow.com/questions/5149544/can-i-generate-a-random-number-inside-a-pixel-shader
float random( vec2 p )
{
    vec2 K1 = vec2(
        23.14069263277926, // e^pi (Gelfond's constant)
         2.665144142690225 // 2^sqrt(2) (Gelfond-Schneider constant)
    );
    return fract( cos( dot(p,K1) ) * 12345.6789 );
}

(texture(TEXTURE, SCREEN_UV + top_right_offset * SCREEN_PIXEL_SIZE).r > 0.0 ? 1 : 0) +
(texture(TEXTURE, SCREEN_UV + center_left_offset * SCREEN_PIXEL_SIZE).r > 0.0 ? 1 : 0) +
(texture(TEXTURE, SCREEN_UV + center_right_offset * SCREEN_PIXEL_SIZE).r > 0.0 ? 1 : 0) +
(texture(TEXTURE, SCREEN_UV + bottom_left_offset * SCREEN_PIXEL_SIZE).r > 0.0 ? 1 : 0) +
(texture(TEXTURE, SCREEN_UV + bottom_middle_offset * SCREEN_PIXEL_SIZE).r > 0.0 ? 1 : 0) +
(texture(TEXTURE, SCREEN_UV + bottom_right_offset * SCREEN_PIXEL_SIZE).r > 0.0 ? 1 : 0);