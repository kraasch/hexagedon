@tool
extends Node

var rng = RandomNumberGenerator.new()
var max_types : int = 3
var colors : Array

func _ready():
	for i in range(0, max_types):
		var sm : ShaderMaterial = ShaderMaterial.new()
		sm.shader = preload("res://data/src/shaders/cube_shader.gdshader")
		sm.set_shader_parameter("type", i)
		colors.push_back(sm)

func rand_color() -> Material:
	var i : int = rng.randf_range(0, max_types)
	return colors[i]
