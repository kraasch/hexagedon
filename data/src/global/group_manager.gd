@tool
extends Node

# NOTE: these two terms are equal: region <==> field group.
# TODO: rename everything to REGION.

const CLICK_COLOR                : int = 0
const SELECTION_COLOR            : int = 10
var   FIELD_GROUPS               : Array = []
var   FIELD_GROUPS_COORDS        : Array = []
var   group_index_clicked_before : int = -1

# TODO: make the MatchOrchestrator/AttackManager the single source of truth for which group 
# was selected. Make the MatchOrchestrator/AttackManager call the GroupManager in order to set
# which group to highlight.

func remove_old_focus() -> void:
	if group_index_clicked_before != -1: # remove old focus, if already exists.
		AttackManager.deselect_group()
		set_field_group_highlight(group_index_clicked_before, false)

# TODO: implement.
func reset_selection(new_color : int) -> void:
	group_index_clicked_before = -1
	set_field_group_highlight(new_color, false)
	print('RESET SELECTION')

func create_new_field_groups(length_val : int) -> void:
	FIELD_GROUPS = []
	FIELD_GROUPS_COORDS = []
	for x in range(length_val):
		FIELD_GROUPS.push_back([])
		FIELD_GROUPS_COORDS.push_back([])

func get_field_group(index : int) -> Array:
	return FIELD_GROUPS[index - 1]

func get_field_group_coords(index : int) -> Array:
	return FIELD_GROUPS_COORDS[index]

func add_tile_to_group(tile, index : int) -> void:
	FIELD_GROUPS[index - 1].push_back(tile)

func add_coordinates_to_group(x : int, y : int, index : int) -> void:
	FIELD_GROUPS_COORDS[index - 1].push_back([x, y])

# TODO: after implementation split into two methods for stack height or field color, to update individually.
# TODO: implement.
func update_field_group_owner_and_stack(index : int) -> void:
	print('update field group')
	var group : Array = get_field_group(index)
	for i in range(len(group)):
		var field = group[i]
		field.update_owner_and_stack()

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
		var has_power : bool = AttackManager.is_attacker_has_enough_power(group_index)
		if player_is_local and group_belongs_to_active and has_power:
			is_disregard = false
	else:
		var last_clicked_belongs_to_active : bool = MapGenerator.group_belongs_to_player(group_index_clicked_before, active_index)
		var is_enemy_region : bool = not group_belongs_to_active
		var is_neighbor : bool = NeighborManager.group_is_neighbor_of_group(group_index_clicked_before, group_index)
		var is_selected_region : bool = group_index_clicked_before == group_index
		if (is_enemy_region and is_neighbor and last_clicked_belongs_to_active) or is_selected_region:
			is_disregard = false
	return is_disregard

# click.
func group_was_clicked(group_index : int) -> void:
	print('click with last: ' + str(group_index_clicked_before) + ' and new: ' + str(group_index))
	if is_disregard_region(group_index):
		return
	# selected group was clicked.
	if group_index_clicked_before == group_index:
		AttackManager.deselect_group()
		set_field_group_highlight(group_index_clicked_before, false)
		group_index_clicked_before = -1
		return
	# another group was clicked.
	set_field_group_highlight(group_index, true, CLICK_COLOR) # set new focus.
	AttackManager.select_group(group_index)
	remove_old_focus()
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
