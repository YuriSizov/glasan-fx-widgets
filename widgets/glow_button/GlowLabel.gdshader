shader_type canvas_item;

uniform vec2 direction = vec2(1.0, 0.0);
uniform float intensity = 1.000000;


// Based on https://github.com/ttencate/blur_godot4/blob/0517d1159b088a272300b083ae98376d9d77ffea/Blur.gdshader.
float blur_alpha(sampler2D source, vec2 uv, vec2 d, float i) {
	vec2 s = i * d / vec2(textureSize(source, 0));

	float blurred =
		0.011194727 * texture(source, uv - 10.000000000 * s).a +
		0.039368696 * texture(source, uv - 8.415809477 * s).a +
		0.071308558 * texture(source, uv - 6.435363708 * s).a +
		0.110237219 * texture(source, uv - 4.455121108 * s).a +
		0.145451038 * texture(source, uv - 2.475020813 * s).a +
		0.163798995 * texture(source, uv - 0.495000167 * s).a +
		0.157439298 * texture(source, uv + 1.485004498 * s).a +
		0.129158204 * texture(source, uv + 3.465057055 * s).a +
		0.090434685 * texture(source, uv + 5.445220765 * s).a +
		0.054043977 * texture(source, uv + 7.425557483 * s).a +
		0.027564604 * texture(source, uv + 9.406126897 * s).a;

	// Allows to disable the effect completely at the cost of being applied twice.
	blurred *= i;

	return blurred;
}


void fragment() {
	vec4 base_color = COLOR;
	float blurred_color = blur_alpha(TEXTURE, UV, direction, intensity);

	COLOR.a = base_color.a + blurred_color;
}
