extends Node

# TODO: remove these fields from here and use MatchOrchestrator as single source of truth.
var group_grid : Array = []
var group_data : Dictionary = {}
var group_num  : int = -1

var last_selected_group = -1

# TODO: implements, look up in NeighborManager.
func is_neighbor(center_tile : int, neighbor_candidate_tile : int):
	return NeighborManager.is_neighbor(center_tile, neighbor_candidate_tile)

# TODO: implement, look up in group_data.
func is_have_different_owner(tile_a : int, tile_b : int):
	return group_data[tile_a] != group_data[tile_b]

# TODO: implement; look up if field_group has a POWER >= 2.
func is_attacker_has_enough_power(tile : int):
	return true

func can_attack(from_tile : int, to_tile : int):
	var are_neighbors : bool = is_neighbor(from_tile, to_tile)
	var are_different : bool = is_have_different_owner(from_tile, to_tile)
	var has_power     : bool = is_attacker_has_enough_power(from_tile)
	return are_neighbors and are_different and has_power

func execute_attack(from_tile : int, to_tile : int):
	print('attack now!')
	return Vector2(0.0, 1.0)

func is_attacker_wins(attack_result : Vector2):
	return attack_result[0] > attack_result[1]

func attack_if_possible(from_tile : int, to_tile : int):
	print('attack if possible')
	if can_attack(from_tile, to_tile):
		var attack_result : Vector2 = execute_attack(from_tile, to_tile)
		print('Tile ' + str(from_tile) + ' attacks tile ' + str(to_tile))
		if is_attacker_wins(attack_result):
			print('attacker wins')
			# TODO: set attacking field power to 1.
			# TODO: set attacked field power to attacking field power - 1.
			# TODO: set attacked field owner to attacker.
		else:
			print('defender wins')
			# TODO: set attacking field power to 1.
	else:
		# TODO: call GroupManager actively here and manage highlighting on map.
		pass

func start_new_match():
	group_grid = MapGenerator.group_grid
	group_data = MapGenerator.group_data
	group_num  = MapGenerator.groups_num

func select_group(group_index : int):
	if last_selected_group != -1 and last_selected_group != group_index:
		attack_if_possible(last_selected_group, group_index)
	last_selected_group = group_index

func deselect_group(group_index : int):
	last_selected_group = -1
