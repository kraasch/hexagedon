extends Node

var rng = RandomNumberGenerator.new()

# TODO: remove these fields from here and use MatchOrchestrator as single source of truth.
var group_grid : Array = []
var group_data : Dictionary = {}
var group_num  : int = -1
var last_selected_group = -1

# look up if both regions are neighbors.
func is_neighbor(center_region : int, neighbor_candidate_region : int):
	return NeighborManager.is_neighbor(center_region, neighbor_candidate_region)

# look up if field groups have different owners.
func is_have_different_owner(region_a : int, region_b : int):
	return group_data[region_a] != group_data[region_b]

# look up if field group has a POWER >= 2.
func is_attacker_has_enough_power(region : int):
	return MapGenerator.get_power_of_region(region) >= 2

# evaluate if a region is able to attack another region.
func can_attack(from_region : int, to_region : int):
	var are_neighbors : bool = is_neighbor(from_region, to_region)
	var are_different : bool = is_have_different_owner(from_region, to_region)
	var has_power     : bool = is_attacker_has_enough_power(from_region)
	return are_neighbors and are_different and has_power

# TODO: implement.
func execute_attack(from_region : int, to_region : int):
	print('attack now!')
	# TODO: get strength of both regions.
	# TODO: get random value depending on strengths.
	return Vector2(0.0, 1.0)

# TODO: implement.
func is_attacker_wins(attack_result : Vector2):
	return attack_result[0] > attack_result[1]

# TODO: implement.
func attack_if_possible(from_region : int, to_region : int):
	print('attack if possible')
	if can_attack(from_region, to_region):
		var attack_result : Vector2 = execute_attack(from_region, to_region)
		print('Tile ' + str(from_region) + ' attacks tile ' + str(to_region))
		if is_attacker_wins(attack_result):
			SfxQueueManager.queue_effect(SfxQueueManager.MOVE_WIN)
			print('attacker wins')
			# TODO: set attacking field power to 1.
			# TODO: set attacked field power to attacking field power - 1.
			# TODO: set attacked field owner to attacker.
		else:
			SfxQueueManager.queue_effect(SfxQueueManager.MOVE_LOST)
			print('defender wins')
			# TODO: set attacking field power to 1.
		MatchOrchestrator.next_active_player()
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
