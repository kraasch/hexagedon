@tool
extends Node3D

const HEX_TILE     : PackedScene = preload("res://data/src/scenes/field.tscn")
const OFFSET_RATIO : float       = Globals.HEX_RATIO
var rng = RandomNumberGenerator.new()

func _ready():
	build_grid()

func build_grid():
	clean_grid()
	var tile_size : float = Globals.EDGE_SIZE
	var grid_size : int   = Globals.GRID_SIZE
	MapGenerator.create_new_map(grid_size)
	GroupManager.create_new_field_groups(MapGenerator.groups_num)
	var group_data = MapGenerator.group_data
	var group_grid = MapGenerator.group_grid

	# create neighbor lists for each field group.
	NeighborManager.create_new_field_neighbors(MapGenerator.groups_num)
	NeighborManager.add_neighbor_data(group_grid)

	# create a new game.
	# TODO: pull out MatchOrchestrator and let HEX_GRID only manage displaying the data.
	MatchOrchestrator.start_new_match()

	# build grid.
	var size : int = len(group_grid)
	for index in range(size * size):
		var x : int = index % size
		var y : int = index / size
		var group_index : int = group_grid[y][x]
		if group_index != 0:
			# new field's data.
			var party_index   : int   = group_data[group_index][0]
			var power_value   : int   = group_data[group_index][1]
			var center_coords : Array = group_data[group_index][2]
			var is_at_center  : bool  = x == center_coords[0] and y == center_coords[1]
			# create new field.
			var tile = HEX_TILE.instantiate()
			tile.set_data(party_index, power_value, group_index, is_at_center)
			GroupManager.add_tile_to_group(tile, group_index)
			%GridContainer.add_child(tile)
			var x_offset : float = 0.0 if x % 2 == 0 else tile_size / 2.0
			var x_coord  : float = x * tile_size * OFFSET_RATIO
			var y_coord  : float = y * tile_size - x_offset
			tile.translate(Vector3(x_coord, 0, y_coord))

#	# build borders of field groups.
#	# - [ ] create a bucket for every group using `groups_num`.
#	for x in range(len(map_groups)):
#		for y in range(len(map_groups[x])):
#			pass
#			# - [ ] for each field, check all neighbors.
#			#   - [ ] IF neighbor is same group THEN ignore.
#			#   - [ ] IF neighbor is different group OR outside of bounds OR empty field
#			#     - [ ] THEN create border object from mesh.
#			#     - [ ] AND THEN add border object id to bucket of both groups (if bucket doesn't contain border yet).

func clean_grid():
	if %GridContainer.get_child_count() > 0:
		# kill all children.
		for n in %GridContainer.get_children():
			%GridContainer.remove_child(n)
			n.queue_free() 
