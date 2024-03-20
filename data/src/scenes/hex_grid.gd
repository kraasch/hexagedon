@tool
extends Node3D

const HEX_TILE     : PackedScene = preload("res://data/src/scenes/field.tscn")
const OFFSET_RATIO : float       = Globals.HEX_RATIO
const tile_size    : float       = Globals.EDGE_SIZE
var   grid_size    : int         = Globals.MAX_GRID_SIZE

func _ready():
	generate_grid()

func generate_grid():
	for x in range(grid_size):
		var coords := Vector2.ZERO
		coords.x = x * tile_size * OFFSET_RATIO
		coords.y = 0 if (x % 2 == 0) else (tile_size / 2)
		for y in range(grid_size):
			var tile = HEX_TILE.instantiate()
			if x == 0 and y == 0:
				tile.set_debug()
				print('now')
			add_child(tile)
			tile.translate(Vector3(coords.x, 0, coords.y))
			coords.y += tile_size
