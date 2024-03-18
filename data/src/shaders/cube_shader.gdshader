shader_type spatial;

uniform int type = -1;

void fragment() {
	vec3 color = vec3(0.0);
	if (type == 0) { // red.
		color = vec3(0.9, 0.4, 0.4);
	} else if (type == 1) { // green.
		color = vec3(0.5, 0.9, 0.4);
	} else if (type == 2) { // blue.
		color = vec3(0.1, 0.1, 0.9);
	} else { // error.
		color = vec3(1.0);
	}
	ALBEDO = color;
}
