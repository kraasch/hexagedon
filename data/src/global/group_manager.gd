@tool
extends Node

# NOTE: these two terms are equal: region <==> field group.
# TODO: rename everything to REGION.

var FIELD_GROUPS               : Array = []
var group_index_clicked_before : int = -1
var CLICK_COLOR                : int = 0
var SELECTION_COLOR            : int = 10

# TODO: make the MatchOrchestrator/AttackManager the single source of truth for which group 
# was selected. Make the MatchOrchestrator/AttackManager call the GroupManager in order to set
# which group to highlight.

func create_new_field_groups(length_val : int) -> void:
	FIELD_GROUPS = []
	for x in range(length_val):
		FIELD_GROUPS.push_back([])

func get_field_group(index : int) -> Array:
	return FIELD_GROUPS[index - 1]

func add_tile_to_group(tile, index : int) -> void:
	FIELD_GROUPS[index - 1].push_back(tile)

func set_field_group_highlight(index : int, turn_on : bool, color_index : int = -1) -> void:
	# TODO: FIXBUG: sometimes the menu tries to access index 3 or 4 but index doesn't exist.
	var group : Array = get_field_group(index)
	for i in range(len(group)):
		var field = group[i] # TODO: add type of field.
		if turn_on:
			field.highlight_group_color(color_index)
		else:
			field.unhighlight_group_color()

# NOTE:
# - before first selection only highlight active player (if he is of type LOCAL).
# - after first selection  only highlight enemy regions (if they are neighbors of a active player region), or is the selected region.
func is_disregard_region(group_index : int) -> bool:
	var is_disregard : bool = true
	var active_index : int = MatchOrchestrator.active_player_index
	var group_belongs_to_active : bool = MapGenerator.group_belongs_to_player(group_index, active_index)
	if group_index_clicked_before == -1:
		var player_is_local : bool = MatchOrchestrator.current_player_is_local()
		if player_is_local and group_belongs_to_active:
			is_disregard = false
	else:
		var is_enemy_region : bool = not group_belongs_to_active
		var is_neighbor_of_active : bool = NeighborManager.group_is_neighbor_of_player(group_index, active_index)
		var is_selected_region : bool = group_index_clicked_before == group_index
		if (is_enemy_region and is_neighbor_of_active) or is_selected_region:
			is_disregard = false
	return is_disregard

# click.
func group_was_clicked(group_index : int) -> void:
	if is_disregard_region(group_index):
		return
	# selected group was clicked.
	if group_index_clicked_before == group_index:
		AttackManager.deselect_group(group_index)
		set_field_group_highlight(group_index_clicked_before, false)
		group_index_clicked_before = -1
		return
	# another group was clicked.
	set_field_group_highlight(group_index, true, CLICK_COLOR) # set new focus.
	AttackManager.select_group(group_index)
	if group_index_clicked_before != -1: # remove old focus, if already exists.
		AttackManager.deselect_group(group_index_clicked_before)
		set_field_group_highlight(group_index_clicked_before, false)
	group_index_clicked_before = group_index # make new focus the old focus for next time.

# hover.
func group_was_selected(group_index : int) -> void:
	if is_disregard_region(group_index):
		return
	if group_index != group_index_clicked_before:
		set_field_group_highlight(group_index, true, SELECTION_COLOR)

# un-hover.
func group_was_deselected(group_index : int) -> void:
	if group_index != group_index_clicked_before:
		set_field_group_highlight(group_index, false)
