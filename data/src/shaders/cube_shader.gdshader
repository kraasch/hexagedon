shader_type spatial;

uniform float intensity = 0.0;

void fragment() {
	ALBEDO = vec3(0.1, 0.1, intensity);
}
