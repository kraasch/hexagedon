@tool
extends Node

var rng = RandomNumberGenerator.new()
var COLORS : Array

func _ready():
	var r : Material = preload("res://data/assets/materials/red.tres")
	var g : Material = preload("res://data/assets/materials/green.tres")
	var b : ShaderMaterial = ShaderMaterial.new()
	b.shader = preload("res://data/src/shaders/cube_shader.gdshader")
	COLORS = [r, g, b]

func rand_color() -> Material:
	var i : int = rng.randf_range(0, len(COLORS))
	return COLORS[i]
