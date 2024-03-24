@tool
extends Node3D

const HEX_TILE     : PackedScene = preload("res://data/src/scenes/field.tscn")
const OFFSET_RATIO : float       = Globals.HEX_RATIO
var rng = RandomNumberGenerator.new()

func _ready():
	generate_grid()

func generate_grid():
	clean_grid()
	var tile_size : float = Globals.EDGE_SIZE
	var grid_size : int   = Globals.GRID_SIZE

	# generate new map.
	MapGenerator.create_new_map_simple(grid_size) # TODO: remove later.
#	MapGenerator.create_new_map(grid_size, grid_size) # TODO: comment back in.

	var map_parties = MapGenerator.party_grid
	var map_groups  = MapGenerator.group_grid
	var center_grid = MapGenerator.center_grid
	var groups_num  = MapGenerator.groups_num
	GroupManager.create_new_field_groups(groups_num)

	# build grid.
	for x in range(len(map_parties)):
		var x_coord : float = x * tile_size * OFFSET_RATIO
		var y_coord : float = 0
		if x % 2 == 0:
			y_coord = tile_size / 2
		for y in range(len(map_parties[x])):
			if map_parties[x][y] != 0:
				# create new field.
				var tile = HEX_TILE.instantiate()
				# NOTE: this highlights the grid's origin in white for orientation.
				var group_id : int = map_groups[x][y]
				tile.set_data(map_parties[x][y], group_id, center_grid[x][y] > 0)
				GroupManager.FIELD_GROUPS[group_id].push_back(tile)
				%GridContainer.add_child(tile)
				tile.translate(Vector3(x_coord, 0, y_coord))
			y_coord += tile_size

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
