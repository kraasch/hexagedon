extends Node3D

func _ready():
	# setup globals.
	SfxQueueManager.init_manager(%GlobalRoot)
	BackgroundMusicManager.init_manager(%GlobalRoot)
	SceneManager.set_scene_root(%ActiveSceneContainer)
	# setup first scene.
	BackgroundMusicManager.transition_to_menu_music()
	SceneManager.set_scene(preload("res://data/src/ui/splash_screen.tscn"))
