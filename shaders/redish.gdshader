shader_type canvas_item;

void fragment() {
	COLOR.r = 0.9;
	COLOR.b = max(COLOR.b, 0.2);
	COLOR.g = max(COLOR.g, 0.2);
}

