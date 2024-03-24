@tool
extends Node

# map grid (assigns each hexagon to a group).
var group_grid  : Array = []

# assigns each hex group to a party.
# - 0: owning party for hex group.
# - 1: power of hex group.
# - 2: array with the x and y coordinates of the hex group's center tile.
var group_data  : Dictionary = {}

# the number of hex groups.
var groups_num  : int = 0

# TODO: use in map geneartor.
#	var max_stack_height : int = Globals.MAX_STACK_HEIGHT
#	var stack_height : int = rng.randi_range(1, max_stack_height) # at least one cube.

@warning_ignore("unused_parameter")
func create_new_map(grid_size):
	groups_num = 4
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
