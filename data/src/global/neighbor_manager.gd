@tool
extends Node

var ALL_REGIONS_NEIGHBORS : Array = []

func is_neighbor(center_group_index : int, neighbor_group_index : int):
	var regions_neighbors : Dictionary = ALL_REGIONS_NEIGHBORS[center_group_index - 1]
	return regions_neighbors.has(neighbor_group_index)

func create_new_field_neighbors(length_val : int):
	ALL_REGIONS_NEIGHBORS = []
	for x in range(length_val):
		ALL_REGIONS_NEIGHBORS.push_back({})# NOTE: use dict as SET with SET[x] = null

func group_is_neighbor_of_group(center_group_num : int, candidate_group_num : int) -> bool:
	var region_neighbors : Dictionary = ALL_REGIONS_NEIGHBORS[center_group_num - 1]
	return region_neighbors.has(candidate_group_num)

func get_neighbors(x : int, y : int) -> Array:
	var is_even : bool = x % 2 == 0
	var neighbors : Array = []
	for i in range(6):
		var relative_neighbor : Dictionary = {}
		if is_even:
			relative_neighbor = RELATIVE_NEIGHBOR_INDEXES_EVEN[i]
		else:
			relative_neighbor = RELATIVE_NEIGHBOR_INDEXES_ODD[i]
		var rx : int = relative_neighbor['x']
		var ry : int = relative_neighbor['y']
		var nx : int = x + rx
		var ny : int = y + ry
		if MapGenerator.is_inside(nx, ny) and not MapGenerator.is_empty_space(nx, ny):
			neighbors.push_back([nx, ny])
	return neighbors

func add_neighbor_data():
	# for each region.
	for i in range(len(ALL_REGIONS_NEIGHBORS)):
		var tiles : Array = GroupManager.get_field_group_coords(i)
		# for each tile in the region.
		for j in range(len(tiles)):
			var tile : Array = tiles[j]
			var x : int = tile[0]
			var y : int = tile[1]
			var region_num : int = MapGenerator.region_index_of_tile(x, y)
			# for every neighbor of the tile.
			var neighbor_tiles : Array = get_neighbors(x, y)
			for k in range(len(neighbor_tiles)):
				var neighbor = neighbor_tiles[k]
				var neighbor_region_num : int = MapGenerator.region_index_of_tile(neighbor[0], neighbor[1])
				# add the tile's group index to the neighboring index list.
				if region_num != neighbor_region_num:
					var region_neighbors = ALL_REGIONS_NEIGHBORS[i]
					region_neighbors[neighbor_region_num] = true

#  HEXAGON GRID LAYOUT.
#
#  Notes.
#  - there is 4 ways to layout a hexagon grid stored in a 2D array.
#  - independent of the layout every hexagon cell has 6 neighbors, except at the borders.
#  - the RELATIVE_NEIGHBOR_INDEXES depend on the relative layout style of the hex cells.
#  - depending on if a cell is in an even or an odd column, the neighboring indexes are different.
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
# +------------------------> x
# |       ,---.     ,---.
# |  ,---. 1,0 .---. 3,0 .
# | . 0,0 .---' 2,0 .---'
# |  ,---' 1,1 .---' 3,1 .
# | . 0,1 .---' 2,1 .---'
# |  ,---' 1,2 .---' 3,2 .
# | . 0,2 .---' 2,2 .---'
# |  `---'  |  `---'      `
# v         |    |
# z        odd  even
#
var RELATIVE_NEIGHBOR_INDEXES_EVEN : Array = [
	{ 'x':  0,  'y': -1}, # center top.
	{ 'x':  0,  'y': +1}, # center bottom.
	{ 'x': -1,  'y':  0}, # left top.
	{ 'x': -1,  'y': +1}, # left bottom.
	{ 'x': +1,  'y':  0}, # right top.
	{ 'x': +1,  'y': +1}, # right bottom.
]
var RELATIVE_NEIGHBOR_INDEXES_ODD : Array = [
	{ 'x':  0,  'y': -1}, # center top.
	{ 'x':  0,  'y': +1}, # center bottom.
	{ 'x': -1,  'y': -1}, # left top.
	{ 'x': -1,  'y':  0}, # left bottom.
	{ 'x': +1,  'y': -1}, # right top.
	{ 'x': +1,  'y':  0}, # right bottom.
]
