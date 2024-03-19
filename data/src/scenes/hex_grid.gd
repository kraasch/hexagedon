@tool
extends Node3D

const PERSPECTIVES : Array = [
	[ Vector3(4, 4, 11), Vector3(-44.8,   0, 0) ],
	[ Vector3(4, 4, -2), Vector3(-44.8, 210.5, 0) ],
	[ Vector3(4, 6, 4), Vector3(-90, 90, 180) ],
]

var perspctives_index : int = 0
var perspctives_max : int = len(PERSPECTIVES)

const TILE_SIZE : float = Globals.EDGE_SIZE
const HEX_TILE = preload("res://data/src/scenes/field.tscn")
var grid_size : int = Globals.MAX_GRID_SIZE
const OFFSET_RATIO : float = cos(deg_to_rad(30))

func _ready():
	generate_grid()

func _process(delta):
	handle_input()

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

func handle_input():
	if Input.is_action_just_pressed("my_cycle_next"):
		apply_perspective(1)
	if Input.is_action_just_pressed("my_cycle_prev"):
		apply_perspective(-1)
	if Input.is_action_just_pressed("my_cycle_center"):
		pass

func apply_perspective(step : int):
	var new_perspective = PERSPECTIVES[perspctives_index]
	var location = new_perspective[0]
	var orientation = new_perspective[1]
	# set values.
	%Camera3D.position.x = location.x
	%Camera3D.position.y = location.y
	%Camera3D.position.z = location.z
	%Camera3D.rotation.x = orientation.x
	%Camera3D.rotation.y = orientation.y
	%Camera3D.rotation.z = orientation.z
	# increment index.
	perspctives_index = (perspctives_index + step) % perspctives_max
