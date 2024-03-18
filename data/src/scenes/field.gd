@tool
extends Node3D

var type_index : int = -1

const CUBE_HEIGHT : float = 0.2
const HEX_TILE = preload("res://data/src/scenes/hex_tile.tscn")
const CUBE = preload("res://data/src/scenes/cube.tscn")
const MIN : int = 0
const MAX : int = 3
@export_range (MIN, MAX) var max_stack_height : int = 6
var rng = RandomNumberGenerator.new()

func _ready():
	type_index = ColorGenerator.rand_num()
	generate_hex_tile()
	generate_cube_stack()

func generate_hex_tile():
	var tile = HEX_TILE.instantiate()
	tile.mymaterial = ColorGenerator.get_shader(type_index)
	add_child(tile)

func generate_cube_stack():
	var stack_height : int = rng.randf_range(0, max_stack_height)
	for i in range(MIN, stack_height):
		var cube = CUBE.instantiate()
		cube.mymaterial = ColorGenerator.get_shader(type_index)
		add_child(cube)
		cube.translate(Vector3(0.0, CUBE_HEIGHT * i, 0.0))
