@tool
extends Node

var rng = RandomNumberGenerator.new()

func get_shader(type_index : int) -> ShaderMaterial:
	var sm : ShaderMaterial = ShaderMaterial.new()
	sm.shader = preload("res://data/src/shaders/cube_shader.gdshader")
	sm.set_shader_parameter("type", type_index)
	sm.set_shader_parameter("random", rng.randf())
	return sm

func rand_num() -> int:
	var max_types : int = Globals.NUM_OF_PARTIES
	return rng.randi_range(1, max_types)
