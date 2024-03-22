extends Node

var FIELD_GROUPS       : Array = []
var group_index_clicked_before : int = -1
var CLICK_COLOR : int = 0
var SELECTION_COLOR : int = 10

func create_new_field_groups(length_val : int):
	length_val = length_val + 1 # NOTE: create extra group at index 0.
	FIELD_GROUPS = []
	for x in range(length_val):
		FIELD_GROUPS.push_back([])

func set_field_group_highlight(index : int, turn_on : bool, color_index : int = -1):
	var group : Array = FIELD_GROUPS[index]
	for i in range(len(group)):
		var field = group[i] # TODO: add type of field.
		if turn_on:
			field.highlight_group_color(color_index)
		else:
			field.unhighlight_group_color()

func group_was_clicked(group_index : int):
	if group_index_clicked_before != -1: # remove old focus.
		set_field_group_highlight(group_index_clicked_before, false)
	set_field_group_highlight(group_index, true, CLICK_COLOR) # set new focus.
	group_index_clicked_before = group_index # make new focus the old focus for next time.

func group_was_selected(group_index : int):
	if group_index != group_index_clicked_before:
		set_field_group_highlight(group_index, true, SELECTION_COLOR)

func group_was_deselected(group_index : int):
	if group_index != group_index_clicked_before:
		set_field_group_highlight(group_index, false)
