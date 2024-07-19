shader_type canvas_item;
uniform float intensity;

// Make image whiter the higher the intensity
void fragment() {
	vec4 real_color = texture(TEXTURE, UV);
	float time_changer = abs(sin(TIME)); // Delete - used just to debug
	if(real_color.a > 0.0) {
		real_color = real_color + vec4(intensity * time_changer);
	}
	COLOR = real_color;
}
