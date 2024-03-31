@tool
extends Node

var scan_type : int = 0 # one of 4 ways to arrange a hexagon grid.

var ALL_REGIONS_NEIGHBORS : Array = []

func is_neighbor(center_group_index : int, neighbor_group_index : int):
	return false
	return ALL_REGIONS_NEIGHBORS[center_group_index].has(neighbor_group_index)

func create_new_field_neighbors(length_val : int):
	ALL_REGIONS_NEIGHBORS = []
	for x in range(length_val):
		ALL_REGIONS_NEIGHBORS.push_back({})# NOTE: use dict as SET with SET[x] = null

#  HEXAGON GRID LAYOUT.
#
#  Conversion of 2D array to one of four hexagon grid layouts.
#  - relative layout style
#    - outer arrays correspond to columns (with one neighbor to the next hightest index).
#    - inner arrays correspond to rows (with two neighbors to the next highest index).
#    - 2nd column pops out.
#
#  Relation of 2D array and world coordinates.
#  - location in world:
#    - origin of hex grid is at origin of coordinate system.
#    - x coordinate corresponds to access to x coordinate and rows (inner arrays).
#    - z coordinate corresponds to access to y coordinate and columns (outer arrays).
#
#  Illustration.
#   .y
#  /
# +------------------> x
# |       ,---.
# |  ,---. 1,0 .---.
# | . 0,0 .---' 2,0 .
# |  ,---' 1,1 .---'
# | . 0,1 .---' 2,1 .
# |  ,---' 1,2 .---'
# | . 0,2 .---' 2,2 .
# |  `---'     `---'
# v
# z
#
#  Notes.
#  - independent of the layout every hexagon cell has 6 neighbors, except at the borders.
func get_neighbors(tile) -> Array:
	return []

func add_neighbor_data(map : Array):
	# for each region.
	for i in range(len(ALL_REGIONS_NEIGHBORS)):
		var tiles : Array = GroupManager.get_field_group(i)
		# for each tile in the region.
		for j in range(len(tiles)):
			var tile = tiles[j]
			# for every neighbor of the tile.
			var neighbor_tiles = get_neighbors(tile)
			for k in range(len(neighbor_tiles)):
				var neighbor = neighbor_tiles[k]
				# add the tile's group index to the neighboring index list.
				var region_neighbors = ALL_REGIONS_NEIGHBORS[i]
				region_neighbors[neighbor] = true
	print('neighbors: ' + str(ALL_REGIONS_NEIGHBORS))

func group_is_neighbor_of_player(group_index : int, player_index : int) -> bool:
	return false
