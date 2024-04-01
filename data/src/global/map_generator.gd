@tool
extends Node

# TODO: create simple map generator.
#  - use 2D noise to make 2D array of 0s (no tile) and 1s (has tile, active region).
#    - input a certain bias for the noise gneration and bias the nosie towards 1s.
#    - if not all 1s are connected, grow disconnected spots of 1s until connected.
#  - equally spread center of field_groups within the active region.
#    - store the centers in group_data.
#  - create a variance value within which to assign grow rates.
#  - assign different grow rates to each field_group.
#  - grow field_group around center until every field group has at least one neihbor.
#    - take turns when growing centers, such that all field groups grow almost equally.

# map grid (assigns each hexagon to a group).
var group_grid : Array = []

# TODO: give better names to these fields, ie by returning dictionary within dictionary.
# assigns each hex group to a party.
# - 0: owning party for hex group.
# - 1: power of hex group.
# - 2: array with the x and y coordinates of the hex group's center tile.
var group_data : Dictionary = {}

# the number of hex groups.
var groups_num : int = 0

# TODO: use in map geneartor.
#	var max_stack_height : int = Globals.MAX_STACK_HEIGHT
#	var stack_height : int = rng.randi_range(1, max_stack_height) # at least one cube.

@warning_ignore("unused_parameter")
func create_new_map(grid_size):
	group_grid = [
		[1, 0, 3, 3],
		[1, 1, 0, 3],
		[2, 0, 0, 4],
		[2, 2, 4, 4],
	]
	group_data = {
		1 : [1, 1, [0, 0]],
		2 : [2, 2, [0, 3]],
		3 : [3, 3, [3, 0]],
		4 : [4, 4, [3, 3]],
	}
#	group_grid = [
#		[1, 0],
#		[0, 2],
#	]
#	group_data = {
#		1 : [1, 1, [0, 0]],
#		2 : [2, 2, [1, 1]],
#	}
	groups_num = len(group_data)

func set_owner_of_region(group_num : int, new_owner : int) -> void:
	group_data[group_num][0] = new_owner

func set_power_of_region(group_num : int, new_power : int) -> void:
	group_data[group_num][1] = new_power

func get_power_of_region(group_num : int) -> int:
	return group_data[group_num][1]

func region_index_of_tile(x : int, y : int) -> int:
	return group_grid[y][x]

func is_empty_space(x : int, y : int) -> bool:
	return region_index_of_tile(x, y) == 0

func is_inside(x : int, y : int) -> bool:
	return x >= 0 and y >= 0 and x < len(group_grid[0]) and y < len(group_grid)

func group_belongs_to_player(group_num : int, player_index : int) -> bool:
	return group_data[group_num][0] == player_index + 1

func number_of_players() -> int:
	var players : Dictionary = {}
	for i in range(len(group_data)):
		var region_data : Array = group_data[i + 1]
		var owning_player : int = region_data[0]
		players[owning_player] = true
	return len(players)

# TODO: buffer this list between turns, and only update after changes to grid happened. (ie detect updates in AttackManager global class).
func player_power_list() -> Dictionary:
	var powers : Dictionary = {}
	for i in range(len(group_data)):
		var region_data : Array = group_data[i + 1]
		var owning_player : int = region_data[0]
		var region_strength : int = region_data[1]
		if powers.has(owning_player):
			powers[owning_player] += region_strength
		else:
			powers[owning_player] = region_strength
	return powers

# TODO: buffer this list between turns, and only update after changes to grid happened. (ie detect updates in AttackManager global class).
func player_region_list() -> Dictionary:
	var regions : Dictionary = {}
	for i in range(len(group_data)):
		var region_data : Array = group_data[i + 1]
		var owning_player : int = region_data[0]
		if regions.has(owning_player):
			regions[owning_player] += 1
		else:
			regions[owning_player] = 1
	return regions

func regions_of_player(index : int) -> int:
	var regions_list : Dictionary = player_region_list()
	return regions_list[index + 1]

func power_of_player(index : int) -> int:
	var power_list : Dictionary = player_power_list()
	return power_list[index + 1]

# a player can make a draw exactly while the player has at least one region with power two.
func player_has_draw(index : int) -> bool:
	return power_of_player(index) > regions_of_player(index)
