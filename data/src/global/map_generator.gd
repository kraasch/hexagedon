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
var group_grid  : Array = []

# TODO: give better names to these fields, ie by returning dictionary within dictionary.
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
