@tool
extends Node3D

#### TODO: give each hexagon a random color.
#var rng = RandomNumberGenerator.new()
#const RED = preload("res://data/assets/materials/red.tres")
#const GREEN = preload("res://data/assets/materials/green.tres")
#const BLUE = preload("res://data/assets/materials/blue.tres")
#const COLORS : Array = [RED, GREEN, BLUE]
#
#func rand_color():
#	var i : int = rng.randf_range(0, 2)
#	return COLORS[i]
##	m.material = rand_color()


func _ready():
	var H : float = 0.3 # height (y level)
	var N : float = 0.5 # length of side.
	var R : float = 0.5 # length or radius.
	
	var CENTER    := Vector3(   0, H,  0)
	var RIGHT     := Vector3(  -N, H,  0)
	var LEFT      := Vector3(   N, H,  0)
	var TOP_LEFT  := Vector3( N/2, H,  N)
	var TOP_RIGHT := Vector3(-N/2, H,  N)
	var BOT_LEFT  := Vector3( N/2, H, -N)
	var BOT_RIGHT := Vector3(-N/2, H, -N)
	
	var vertices = PackedVector3Array()
	vertices.push_back(CENTER)
	vertices.push_back(TOP_LEFT)
	vertices.push_back(TOP_RIGHT)
	vertices.push_back(RIGHT)
	vertices.push_back(BOT_RIGHT)
	vertices.push_back(BOT_LEFT)
	vertices.push_back(LEFT)

	var indexes = PackedInt32Array([
			0,1,2,
			0,2,3,
			0,3,4,
			0,4,5,
			0,5,6,
			0,6,1,
		])
	
	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indexes
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	# Create the Mesh.
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	add_child(m)
