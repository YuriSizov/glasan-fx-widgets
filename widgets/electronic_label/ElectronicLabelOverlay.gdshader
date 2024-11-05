shader_type canvas_item;

uniform float glass_shine_offset: hint_range(-1.0, 1.0) = 0.0;
uniform float glass_shine_sharpness: hint_range(0.0, 0.5) = 0.01;
uniform float glass_shine_opaqueness: hint_range(0.0, 1.0) = 0.64;

uniform float vignette_center: hint_range(1.0, 50.0) = 15.0;
uniform float vignette_rim: hint_range(0.0, 4.0) = 0.5;
uniform float vignette_intensity: hint_range(0.0, 1.0) = 0.0;


// Adds an overlay on top of the base color, following the blend factor and the mask.
vec3 overlay(vec3 base_color, vec3 overlay_color, float overlay_blend, float mask) {
	return mix(base_color, overlay_color, overlay_blend) * mask + base_color * (1.0 - mask);
}


void fragment() {
	vec2 uv = UV;
	vec3 output_color = COLOR.rgb;
	float output_alpha = 0.0;

	// Create a shiny overlay.
	float glass_shine = (uv.x + uv.y) / 2.0;
	float glass_shine_position = (glass_shine_offset + 1.0) / 2.0;
	glass_shine = smoothstep(glass_shine_position - glass_shine_sharpness, glass_shine_position + glass_shine_sharpness, glass_shine);
	glass_shine = (1.0 - glass_shine);

	// Apply the opaqueness factor.
	glass_shine *= glass_shine_opaqueness;
	// Add the shiny overlay to the output color.
	output_color = overlay(output_color, vec3(glass_shine), glass_shine, glass_shine);
	output_alpha += glass_shine;

	// Create a vignette/shadow overlay.
	vec2 vignette_uv = UV * (1.0 - UV.yx);
	float vignette_value = clamp(pow(vignette_uv.x * vignette_uv.y * vignette_center, vignette_rim), 0.0, 1.0);
	// Add the vignette overlay to the output color.
	output_color = overlay(output_color, vec3(0.075), (1.0 - vignette_value), vignette_intensity);
	output_alpha += (1.0 - vignette_value);

	// Output.
	COLOR = vec4(output_color, output_alpha);
}
