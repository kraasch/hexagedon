extends Node3D

var parent = null

func _ready():
	parent = $"../.."
	GroupManager.create_new_field_groups(2)
	%SP.set_data(1, 1, false)
	%SP.set_callback(sp_clicked)
	%MP.set_data(2, 2, false)
	%MP.set_callback(mp_clicked)
	GroupManager.FIELD_GROUPS[1].push_back(%SP)
	GroupManager.FIELD_GROUPS[2].push_back(%MP)

# TODO: prevent double-clicks.
func sp_clicked():
	SceneManager.set_scene(preload("res://data/tools/src/map_viewer_tool.tscn"))

func mp_clicked():
	print('multi player')
