@tool
extends Node3D


const CUBE_HEIGHT : float = 0.2
const HEX_TILE = preload("res://data/src/scenes/hex_tile.tscn")
const CUBE = preload("res://data/src/scenes/cube.tscn")
var max_stack_height : int = Globals.MAX_STACK_HEIGHT
var rng = RandomNumberGenerator.new()

var is_debug : bool = false # NOTE: remove later. only for debugging colors.

func _ready():
	var type_index : int = ColorGenerator.rand_num()
	generate_hex_tile(type_index)
#	generate_cube_stack(type_index) # TODO: render in center of field.

func generate_hex_tile(type_index : int):
	var tile = HEX_TILE.instantiate()
	if not is_debug:
		tile.mymaterial = ColorGenerator.get_shader(type_index)
	else:
		tile.mymaterial = ColorGenerator.get_shader(-1)
	add_child(tile)

func generate_cube_stack(type_index : int):
	var stack_height : int = rng.randf_range(0, max_stack_height)
	for i in range(0, stack_height):
		var cube = CUBE.instantiate()
		cube.mymaterial = ColorGenerator.get_shader(type_index)
		add_child(cube)
		cube.translate(Vector3(0.0, CUBE_HEIGHT * i, 0.0))

func set_debug():
	is_debug = true
