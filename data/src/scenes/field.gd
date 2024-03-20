@tool
extends Node3D

const HEX_TILE = preload("res://data/src/scenes/hex_tile.tscn")
const CUBE = preload("res://data/src/scenes/cube.tscn")
var rng = RandomNumberGenerator.new()
var is_debug : bool = false # NOTE: remove later. only for debugging colors.

func _ready():
	var type_index : int = ColorGenerator.rand_num()
	generate_hex_tile(type_index)
	generate_cube_stack(type_index) # TODO: render in center of FIELD GROUP.

func generate_hex_tile(type_index : int):
	var tile = HEX_TILE.instantiate()
	if not is_debug: # TODO: remove later.
		tile.mymaterial = ColorGenerator.get_shader(type_index)
	else:
		tile.mymaterial = ColorGenerator.get_shader(-1)
	add_child(tile)

func generate_cube_stack(type_index : int):
	var max_stack_height : int = Globals.MAX_STACK_HEIGHT
	var cube_height : float = Globals.CUBE_SIZE
	var stack_height : int = rng.randi_range(0, max_stack_height)
	for i in range(0, stack_height): # TODO: if stack heigh is more than 4 or so split into two columns.
		var cube = CUBE.instantiate()
		cube.mymaterial = ColorGenerator.get_shader(type_index)
		add_child(cube)
		cube.translate(Vector3(0.0, cube_height * i, 0.0))

func set_debug(): # TODO: remove later.
	is_debug = true
