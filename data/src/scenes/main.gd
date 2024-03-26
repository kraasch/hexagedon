extends Node3D

func _ready():
	BackgroundMusicManager.init_manager(%GlobalRoot)
	BackgroundMusicManager.transition_to_menu_music()
	SceneManager.set_scene_root(%ActiveSceneContainer)
	SceneManager.set_scene(preload("res://data/src/ui/splash_screen.tscn"))
