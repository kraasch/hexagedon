shader_type spatial;

uniform int type = -1;
uniform float random = 0.0;

void fragment() {
	vec3 color = vec3(0.0);
	float pendulum = abs(mod(TIME + random, 2.0) - 1.0);
	float main = UV.x * (pendulum + 0.2);

	if (type == 1) { // red.
		color = vec3(main, 0.4, 0.4);

	} else if (type == 2) { // green.
		color = vec3(0.5, main, 0.4);

	} else if (type == 3) { // blue.
		color = vec3(0.1, 0.1, main);

	} else if (type == 4) { // pink?
		color = vec3(main, main, 0.1);

	} else if (type == 5) { // magenta?
		color = vec3(0.1, main, main);

	} else if (type == 6) { // cyan?
		color = vec3(main, 0.1, main);

	} else if (type == 7) { // TODO: write name of color here.
		color = vec3(0.5, 0.1, 0.4);

	} else if (type == 8) { // TODO: write name of color here.
		color = vec3(0.1, 0.4, 0.7);

	} else if (type == 9) { // TODO: write name of color here.
		color = vec3(0.6, 0.3, 0.5);

	} else if (type == 10) { // TODO: write name of color here.
		color = vec3(0.5, 0.7, 0.4);

	} else { // error.
		color = vec3(1.0);
	}

	ALBEDO = color;
}
