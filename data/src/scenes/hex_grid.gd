@tool
extends Node3D

const HEX_TILE     : PackedScene = preload("res://data/src/scenes/field.tscn")
const OFFSET_RATIO : float       = Globals.HEX_RATIO
var rng = RandomNumberGenerator.new()

var map = null

func _ready():
	generate_grid()

func generate_grid():
	clean_grid()
	var tile_size : float = Globals.EDGE_SIZE
	var grid_size : int   = Globals.GRID_SIZE

	map = [
		[1, 1, 3, 0],
		[1, 0, 3, 3],
		[2, 2, 0, 1],
		[0, 2, 1, 0],
	]

	# create grid.
#	map = []
#	for x in range(grid_size):
#		var map_line = []
#		for y in range(grid_size):
#			var type_index : int = ColorGenerator.rand_num()
#			map_line.push_back(type_index)
#		map.push_back(map_line)

	# build grid.
	for x in range(len(map)):
		var x_coord : float = x * tile_size * OFFSET_RATIO
		var y_coord : float = 0 if x % 2 == 0 else tile_size / 2
		for y in range(len(map[x])):
			if map[x][y] != 0:
				var tile = HEX_TILE.instantiate()
				if x == 0 and y == 0: # TODO: remove later.
					tile.set_debug()
				tile.set_data(map[x][y])
				%GridContainer.add_child(tile)
				tile.translate(Vector3(x_coord, 0, y_coord))
			y_coord += tile_size

func clean_grid():
	if %GridContainer.get_child_count() > 0:
		# kill all children.
		for n in %GridContainer.get_children():
			%GridContainer.remove_child(n)
			n.queue_free() 
