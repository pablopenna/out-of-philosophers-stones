shader_type canvas_item;
uniform float intensity;

void fragment() {
	vec4 real_color = texture(TEXTURE, UV);
	// float time_changer = abs(sin(TIME)); // Delete - used just to debug
	if(real_color.a > 0.0) {
		real_color.a = intensity;
	}
	COLOR = real_color;
}
