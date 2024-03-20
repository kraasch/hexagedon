@tool
extends Node3D

const HEX_TILE = preload("res://data/src/scenes/hex_tile.tscn")
const CUBE = preload("res://data/src/scenes/cube.tscn")
var rng = RandomNumberGenerator.new()
var is_debug : bool = false # NOTE: remove later. only for debugging colors.
var type_index : int = -1
var field_group_id : int = -1

func set_data(_type_index : int, _field_group_id : int):
	type_index = _type_index
	field_group_id = _field_group_id

func _ready():
	generate_hex_tile(type_index)
	generate_cube_stack(type_index) # TODO: render in center of FIELD GROUP.

func generate_hex_tile(type_index : int):
	var tile = HEX_TILE.instantiate()
	if is_debug: # TODO: remove later.
		tile.mymaterial = ColorGenerator.get_shader(-1)
	else:
		tile.mymaterial = ColorGenerator.get_shader(type_index)
	add_child(tile)

func generate_cube_stack(type_index : int):
	var max_stack_height : int = Globals.MAX_STACK_HEIGHT
	var cube_height : float = Globals.CUBE_SIZE
	var split_index : int = max_stack_height / 2
	var half_stack_height : float = cube_height * split_index
	var stack_height : int = rng.randi_range(0, max_stack_height)
	for i in range(0, stack_height):
		# basic cube setup.
		var cube = CUBE.instantiate()
		cube.mymaterial = ColorGenerator.get_shader(type_index)
		add_child(cube)
		# calculate height offset.
		var height_offset : float = cube_height * i
		# subtract half the stack height for second part of stack.
		if i >= split_index: height_offset -= half_stack_height
		# calculate sidewas offset.
		var sideways_offset : float = 0.0
		var left_or_right_offset : float = 1.0 if i < split_index else -1.0
		sideways_offset = cube_height / 2.0 + Globals.STACK_SPLIT_GAP
		sideways_offset = sideways_offset * left_or_right_offset
		# move cube to right place.
		cube.translate(Vector3(0.0, height_offset, sideways_offset))

func set_debug(): # TODO: remove later.
	is_debug = true
