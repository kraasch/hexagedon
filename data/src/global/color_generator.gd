@tool
extends Node

var rng = RandomNumberGenerator.new()
var max_types : int = Globals.MAX_NUM_OF_PARTIES
var colors : Array

func get_shader(type_index : int) -> ShaderMaterial:
	var sm : ShaderMaterial = ShaderMaterial.new()
	sm.shader = preload("res://data/src/shaders/cube_shader.gdshader")
	sm.set_shader_parameter("type", type_index)
	sm.set_shader_parameter("random", rng.randf())
	return sm

func rand_num() -> int:
	var i : int = rng.randf_range(0, max_types)
	return i
