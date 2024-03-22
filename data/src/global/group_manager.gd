extends Node

var FIELD_GROUPS       : Array = []
var group_index_before : int = -1

func create_new_field_groups(length_val : int):
	length_val = length_val + 1 # NOTE: create extra group at index 0.
	FIELD_GROUPS = []
	for x in range(length_val):
		FIELD_GROUPS.push_back([])

func set_field_group_highlight(index : int, turn_on : bool):
	var group : Array = FIELD_GROUPS[index]
	for i in range(len(group)):
		var field = group[i] # TODO: add type of field.
		if turn_on:
			field.highlight_group_color()
		else:
			field.unhighlight_group_color()

func group_was_clicked(group_index : int):
	# remove old focus.
	if group_index_before != -1:
		set_field_group_highlight(group_index_before, false)
	# set new focus.
	set_field_group_highlight(group_index, true)
	# make new focus the old focus for next time.
	group_index_before = group_index
