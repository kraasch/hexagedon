@tool
extends Node

var scan_type : int = 0 # one of 4 ways to arrange a hexagon grid.

var FIELD_NEIGHBORS : Array = []

func is_neighbor(center_group_index : int, neighbor_group_index : int):
	return false
	return FIELD_NEIGHBORS[center_group_index].has(neighbor_group_index)

func create_new_field_neighbors(length_val : int):
	FIELD_NEIGHBORS = []
	for x in range(length_val):
		FIELD_NEIGHBORS.push_back({})# NOTE: use dict as SET with SET[x] = null

# NOTE: in its general form this function should pay attention to the scan_type.
func get_neighbors(tile):
	return []

func add_neighbor_data(map : Array):
	pass
#	# for each field group make field group centeral group.
#	for central_group_index in range(len(FIELD_NEIGHBORS)):
#		# collection of all fields for the central field group.
#		var field_group = GroupManager.get_field_group(central_group_index)
#		#for each tile in the central field group.
#		for tile_index in range(len(field_group)):
#			var tile = field_group[tile_index]
#			# for every neighbor of the tile.
#			var neighbor_tiles = get_neighbors(tile) # TODO: implement.
#			for neighbor_index in range(len(neighbor_tiles)):
#				var neighbor = neighbor_tiles[neighbor_index]
#				# add the tile's group index to the neighboring index list.
#				FIELD_NEIGHBORS[central_group_index].push_back(neighbor)
