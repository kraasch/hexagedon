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

# TODO: implement.
func group_is_neighbor_of_player(group_index : int, player_index : int) -> bool:
#	var region_neighbors = ALL_REGIONS_NEIGHBORS[group_index]
	return false

# TODO: implement.
func get_neighbors(x : int, y : int) -> Array:
	var neighbors : Array = []
	for i in range(len(RELATIVE_NEIGHBOR_INDEXES)):
		var relative_neighbor : Dictionary = RELATIVE_NEIGHBOR_INDEXES[i]
		var rx : int = relative_neighbor['x']
		var ry : int = relative_neighbor['y']
		var nx : int = x + rx
		var ny : int = y + ry
		if MapGenerator.is_inside(nx, ny) and not MapGenerator.is_empty_space(nx, ny):
			neighbors.push_back([nx, ny])
	return neighbors

# TODO: implement.
func add_neighbor_data(map : Array):
	# for each region.
	for i in range(len(ALL_REGIONS_NEIGHBORS)):
		var tiles : Array = GroupManager.get_field_group_coords(i)
		# for each tile in the region.
		for j in range(len(tiles)):
			var tile : Array = tiles[j]
			var x : int = tile[0]
			var y : int = tile[1]
			# for every neighbor of the tile.
			var neighbor_tiles : Array = get_neighbors(x, y)
			print(neighbor_tiles) # TODO: remove
			for k in range(len(neighbor_tiles)):
				var neighbor = neighbor_tiles[k]
				# TODO: get region index of tile.
				var region_index : int = MapGenerator.region_index_of_tile(neighbor[0], neighbor[1])
				# add the tile's group index to the neighboring index list.
				var region_neighbors = ALL_REGIONS_NEIGHBORS[i]
				region_neighbors[region_index] = true
	print('neighbors: ' + str(ALL_REGIONS_NEIGHBORS))

#  HEXAGON GRID LAYOUT.
#
#  Notes.
#  - there is 4 ways to layout a hexagon grid stored in a 2D array.
#  - independent of the layout every hexagon cell has 6 neighbors, except at the borders.
#  - the RELATIVE_NEIGHBOR_INDEXES depend on the relative layout style of the hex cells.
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
var RELATIVE_NEIGHBOR_INDEXES : Array = [
	{ 'x':  0,  'y': -1}, # center top.
	{ 'x':  0,  'y': +1}, # center bottom.
	{ 'x': -1,  'y': -1}, # left top.
	{ 'x': -1,  'y':  0}, # left bottom.
	{ 'x': +1,  'y': -1}, # right top.
	{ 'x': +1,  'y':  0}, # right bottom.
]
