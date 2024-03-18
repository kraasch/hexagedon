@tool
extends Node3D

const TILE_SIZE : float = 1.0
const HEX_TILE = preload("res://data/src/scenes/field.tscn")
@export_range (2, 20) var grid_size : int = 10
const OFFSET_RATIO : float = cos(deg_to_rad(30))

func _ready():
	generate_grid()

func generate_grid():
	for x in range(grid_size):
		var coords := Vector2.ZERO
		coords.x = x * TILE_SIZE * OFFSET_RATIO
		coords.y = 0 if (x % 2 == 0) else (TILE_SIZE / 2)
		for y in range(grid_size):
			var tile = HEX_TILE.instantiate()
			add_child(tile)
			tile.translate(Vector3(coords.x, 0, coords.y))
			coords.y += TILE_SIZE
