@tool
extends Node3D

const HEX_TILE     : PackedScene = preload("res://data/src/scenes/field.tscn")
const OFFSET_RATIO : float       = Globals.HEX_RATIO

func _ready():
	new_map()

func generate_grid():
	clean_grid()
	clean_grid()
	var   tile_size    : float       = Globals.EDGE_SIZE
	var   grid_size    : int         = Globals.MAX_GRID_SIZE
	print('tile size: ' + str(tile_size))
	print('grid size: ' + str(grid_size))
	for x in range(grid_size):
		var coords := Vector2.ZERO
		coords.x = x * tile_size * OFFSET_RATIO
		coords.y = 0 if (x % 2 == 0) else (tile_size / 2)
		for y in range(grid_size):
			var tile = HEX_TILE.instantiate()
			if x == 0 and y == 0:
				tile.set_debug()
			%GridContainer.add_child(tile)
			tile.translate(Vector3(coords.x, 0, coords.y))
			coords.y += tile_size

func clean_grid():
	if %GridContainer.get_child_count() > 0:
		print('there is things to DELETE')
		# kill all children.
		for n in %GridContainer.get_children():
			%GridContainer.remove_child(n)
			n.queue_free() 
	else:
		print('all is FINE')

func new_map():
	generate_grid()
