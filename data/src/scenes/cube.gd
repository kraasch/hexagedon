@tool
extends Node3D

var mymaterial : Material = Material.new()

func _ready():

	const ELEVATION : float = 0.3                 # elevation i.e. distance above the ground (y coordinate).
	var CUBE_HEIGHT : float = Globals.CUBE_SIZE # choose size (eg. half the tile distance).
	var F : float = CUBE_HEIGHT / 2.0           # half of N.
	var ELEVATION_TOP : float = ELEVATION + CUBE_HEIGHT

	# bottom square.
	var BRL := Vector3(-F, ELEVATION, +F)
	var BRR := Vector3(+F, ELEVATION, +F)
	var BFL := Vector3(-F, ELEVATION, -F)
	var BFR := Vector3(+F, ELEVATION, -F)

	# tops square.
	var TRL := Vector3(-F, ELEVATION_TOP, +F)
	var TRR := Vector3(+F, ELEVATION_TOP, +F)
	var TFL := Vector3(-F, ELEVATION_TOP, -F)
	var TFR := Vector3(+F, ELEVATION_TOP, -F)
	
	var vertices = PackedVector3Array()
	vertices.push_back(BRL) # 0
	vertices.push_back(BRR) # 1
	vertices.push_back(BFL) # 2
	vertices.push_back(BFR) # 3

	vertices.push_back(TRL) # 4
	vertices.push_back(TRR) # 5
	vertices.push_back(TFL) # 6
	vertices.push_back(TFR) # 7

	var indexes = PackedInt32Array([
		# bottom face.
		0,1,2,
		2,1,3,
		# top face.
		6,5,4,
		7,5,6,
		# left-side face.
		0,2,4,
		4,2,6,
		# right-side face.
		5,3,1,
		7,3,5,
		# front face.
		2,3,6,
		7,6,3,
		# rear face.
		4,1,0,
		1,4,5,
	])

	var uvs = PackedVector2Array([
		Vector2(0,0),
		Vector2(1,0),
		Vector2(1,1),
		Vector2(0,1),

		Vector2(0,0),
		Vector2(1,0),
		Vector2(1,1),
		Vector2(0,1),
	])

	# Initialize the ArrayMesh.
	var arr_mesh = ArrayMesh.new()
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	arrays[Mesh.ARRAY_VERTEX] = vertices
	arrays[Mesh.ARRAY_INDEX] = indexes
	arrays[Mesh.ARRAY_TEX_UV] = uvs
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)

	# Create the Mesh.
	var m = MeshInstance3D.new()
	m.mesh = arr_mesh
	m.material_override = mymaterial
	add_child(m)
