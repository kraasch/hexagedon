@tool
extends Node3D

# NOTE: The FIELD is a HEX TILE with the potential of having a CUBE stack on top.
# The field has a cube stack in case the hexagon tile is picked to be the center 
# of the FIELD GROUP.

const HEX_TILE : PackedScene = preload("res://data/src/scenes/hex_tile.tscn")
const CUBE     : PackedScene = preload("res://data/src/scenes/cube.tscn")
var   tile                   = null
var   is_debug       : bool  = false # NOTE: remove later. only for debugging colors.
var   type_index     : int   = -1
var   field_group_id : int   = -1
var   power_value    : int   = 0
var   is_center      : bool  = false
var   callback_clicked = null
var   stack_buffer   : Array = []

# TODO: after implementation split into two methods for stack height or field color, to update individually.
# TODO: implement.
func update_owner_and_stack():
	power_value = MapGenerator.get_power_of_region(field_group_id)
	var owner : int = MapGenerator.get_owner_of_region(field_group_id)
	print('UPDATE FIELD')
	# redraw tile.
	highlight_group_color(owner)
	# redraw cube stack.
	if is_center:
		for i in range(len(stack_buffer)):
			var cube = stack_buffer[i]
			cube.queue_free()
		generate_cube_stack()

func set_data(_type_index : int, _power_value : int, _field_group_id : int, _is_center : bool):
	type_index     = _type_index
	power_value    = _power_value
	field_group_id = _field_group_id
	is_center      = _is_center

func set_callback(_callback_clicked):
	callback_clicked = _callback_clicked

func _ready():
	generate_hex_tile()
	if is_center:
		generate_cube_stack()

func generate_hex_tile():
	tile = HEX_TILE.instantiate()
	tile.set_callback(was_clicked, was_selected, was_deselected)
	tile.mymaterial = ColorGenerator.get_shader(type_index)
	add_child(tile)

func was_clicked():
	GroupManager.group_was_clicked(field_group_id)
	if callback_clicked != null:
		callback_clicked.call()

func was_selected():
	GroupManager.group_was_selected(field_group_id)

func was_deselected():
	GroupManager.group_was_deselected(field_group_id)

func highlight_group_color(color_index : int):
	tile.mymaterial.set_shader_parameter("type", color_index)

func unhighlight_group_color():
	tile.mymaterial.set_shader_parameter("type", type_index)

@warning_ignore("integer_division")
func generate_cube_stack():
	stack_buffer = []
	var max_stack_height : int = Globals.MAX_STACK_HEIGHT
	var cube_height : float = Globals.CUBE_SIZE
	var split_index : int = max_stack_height / 2
	var half_stack_height : float = cube_height * split_index
	for i in range(0, power_value):
		# basic cube setup.
		var cube = CUBE.instantiate() # TODO: add type.
		cube.mymaterial = ColorGenerator.get_shader(type_index)
		add_child(cube)
		stack_buffer.push_back(cube)
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
