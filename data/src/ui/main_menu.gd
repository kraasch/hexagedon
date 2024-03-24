extends Control

func _ready():
	%MP.pressed.connect(mp_clicked)
	%SP.pressed.connect(sp_clicked)

# TODO: prevent double-clicks.
func sp_clicked():
	SceneManager.set_scene(preload("res://data/tools/src/map_viewer_tool.tscn"))

func mp_clicked():
	print('multi player')
