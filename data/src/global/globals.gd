@tool
extends Node

# Never changing globals.
const HEX_RATIO        : float = cos(deg_to_rad(30))
const EDGE_SIZE        : float = 1.0
const STACK_SPLIT_GAP  : float = 0.01
const HEX_TILE_GAP     : float = 0.005

# Change these values to alter the graphics.
var MAX_STACK_HEIGHT   : int = 8
var NUM_OF_PARTIES     : int = 6
var GRID_SIZE          : int = 4
var CUBE_SIZE          : float = 0.3

###############################################################
# MAP MANAGEMER (Maybe make it its own class later)
###############################################################
var FIELD_GROUPS       : Array = []
var group_index_before : int = -1

func create_new_field_groups(length_val : int):
	length_val = length_val + 1 # NOTE: create extra group at index 0.
	FIELD_GROUPS = []
	for x in range(length_val):
		FIELD_GROUPS.push_back([])

func group_was_clicked(group_index : int):
	# remove old focus.
	if group_index_before != -1:
		var field_group_before : Array = FIELD_GROUPS[group_index_before]
		for i in range(len(field_group_before)):
			var field = field_group_before[i] # TODO: add type of field.
			field.unhighlight_group_color()

	# set new focus.
	# TODO: implement to inform all fields in group to change color.
	var field_group : Array = FIELD_GROUPS[group_index]
	for i in range(len(field_group)):
		var field = field_group[i] # TODO: add type of field.
		field.highlight_group_color()

	# make new focus the old focus for next time.
	group_index_before = group_index
