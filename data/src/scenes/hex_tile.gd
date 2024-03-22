@tool
extends Node3D

@export var mymaterial : Material = Material.new()

var activate = null
var select = null
var deselect = null

func _ready():
	
	const H_TO_N_RATIO : float = 1.0 / cos(deg_to_rad(30.0))
	var TILE_SIZE : float = Globals.EDGE_SIZE - Globals.HEX_TILE_GAP # distance from one tile to the next.
	const ELEVATION : float = 0.3        # elevation i.e. distance above the ground (y coordinate).
	var H : float = TILE_SIZE / 2.0      # height of triangles.
	var N : float = H * H_TO_N_RATIO     # length of hexagon edges (also length of triangle edges).
	var M : float = N / 2.0              # half of N.

	var CENTER    := Vector3(  0.0,  ELEVATION,  0.0 )
	var RIGHT     := Vector3(   -N,  ELEVATION,  0.0 )
	var LEFT      := Vector3(    N,  ELEVATION,  0.0 )
	var TOP_LEFT  := Vector3(    M,  ELEVATION,    H )
	var TOP_RIGHT := Vector3(   -M,  ELEVATION,    H)
	var BOT_LEFT  := Vector3(    M,  ELEVATION,   -H )
	var BOT_RIGHT := Vector3(   -M,  ELEVATION,   -H )

	var vertices = PackedVector3Array()
	vertices.push_back(CENTER)
	vertices.push_back(TOP_LEFT)
	vertices.push_back(TOP_RIGHT)
	vertices.push_back(RIGHT)
	vertices.push_back(BOT_RIGHT)
	vertices.push_back(BOT_LEFT)
	vertices.push_back(LEFT)

	var indexes = PackedInt32Array([
			# top face.
			0,1,2,
			0,2,3,
			0,3,4,
			0,4,5,
			0,5,6,
			0,6,1,
			# bottom face.
			2,1,0,
			3,2,0,
			4,3,0,
			5,4,0,
			6,5,0,
			1,6,0,
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
	m.material_override = mymaterial
	add_child(m)

func set_callback(_activate, _select, _deselect):
	activate = _activate
	select   = _select
	deselect = _deselect

func _on_area_3d_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if activate != null:
				activate.call()

func _on_area_3d_mouse_entered():
	if select != null:
		select.call()

func _on_area_3d_mouse_exited():
	if deselect != null:
		deselect.call()
