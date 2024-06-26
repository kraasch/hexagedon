extends Node

var rng = RandomNumberGenerator.new()

# TODO: remove these fields from here and use MatchOrchestrator as single source of truth.
var group_grid : Array      = []
var group_data : Dictionary = {}
var group_num  : int        = -1
var last_selected_group     = -1
var allow_selection : bool  = true

# look up if field groups have different owners.
func is_have_different_owner(region_a : int, region_b : int):
	return group_data[region_a] != group_data[region_b]

# look up if field group has a POWER >= 2.
func is_attacker_has_enough_power(region : int):
	return MapGenerator.get_power_of_region(region) >= 2

# evaluate if a region is able to attack another region.
func can_attack(from_region : int, to_region : int):
	var are_neighbors : bool = NeighborManager.is_neighbor(from_region, to_region)
	var are_different : bool = is_have_different_owner(from_region, to_region)
	var has_power     : bool = is_attacker_has_enough_power(from_region)
	print('  are_neighbors: ' + str(are_neighbors))
	print('  are_different: ' + str(are_different))
	print('  has_power:     ' + str(has_power))
	return are_neighbors and are_different and has_power

# defines the wind condition for an attack.
func is_attacker_wins(attack_result : Vector2):
	return attack_result[0] > attack_result[1]

# get results of dice toss for defending and attacking region.
func execute_attack(from_region : int, to_region : int):
	var from_strength : int = MapGenerator.get_power_of_region(from_region)
	var to_strength   : int = MapGenerator.get_power_of_region(to_region)
	var from_attack   : int = rng.randi_range(1, from_strength * 6)
	var to_defence    : int = rng.randi_range(1, to_strength * 6)
	print('attack now!')
	print('  attack: ' + str(from_attack) + ', defence: ' + str(to_defence))
	return Vector2(from_attack, to_defence)

# TODO: implement.
func attack_if_possible(from_region : int, to_region : int):
	var attacker_number : int = MatchOrchestrator.active_player_index + 1
	print('attack if possible')
	if can_attack(from_region, to_region):
		var attack_result : Vector2 = execute_attack(from_region, to_region)
		print('  region #' + str(from_region) + ' attacks region #' + str(to_region))
		if is_attacker_wins(attack_result):
			print('  attacker wins') # TODO: remove later.
			# play sound.
			SfxQueueManager.queue_effect(SfxQueueManager.MOVE_WIN)
			# set attacked field power to attacking field power - 1.
			# TODO: use signals for updating the change of power graphically.
			MapGenerator.set_power_of_region(to_region, MapGenerator.get_power_of_region(from_region) - 1)
			# set attacking field power to 1.
			# TODO: use signals for updating the change of power graphically.
			MapGenerator.set_power_of_region(from_region, 1)
			# set attacked field owner to attacker.
			# TODO: signal change of owner to UI.
			MapGenerator.set_owner_of_region(to_region, attacker_number)
		else:
			print('  defender wins') # TODO: remove later.
			# play sound.
			SfxQueueManager.queue_effect(SfxQueueManager.MOVE_LOST)
			# set attacking field power to 1.
			MapGenerator.set_power_of_region(from_region, 1)

		# TODO: signal change of power to UI.
		# reset slection.
		AttackManager.deselect_group()
		GroupManager.reset_selection(attacker_number)
		# update fields (eg color of tiles).
		GroupManager.update_field_group_owner_and_stack(from_region)
		GroupManager.update_field_group_owner_and_stack(to_region)
		# TODO: redistribute new cubes after round.

		# More tasks:
		# TODO: calculate the maximum number of connected regions.
		# TODO: use connected regions for redistribute at end of turn.
		# TODO: use connected regions in player list display.

	else:
		# TODO: call GroupManager actively here and manage highlighting on map: show visually that region cannot be attacked.
		pass

	# carry out attack.
	get_tree().create_timer(2).timeout.connect(attack_over)

func attack_over():
	GroupManager.deselect_current()
	allow_selection = true

func start_new_match():
	group_grid = MapGenerator.group_grid
	group_data = MapGenerator.group_data
	group_num  = MapGenerator.groups_num

func select_group(group_index : int):
	if last_selected_group != -1 and last_selected_group != group_index:
		allow_selection = false
		attack_if_possible(last_selected_group, group_index)
	last_selected_group = group_index

func deselect_group():
	last_selected_group = -1
