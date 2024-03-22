extends Node3D

func _ready():
	SceneManager.set_scene_root(%ActiveSceneContainer)
	SceneManager.set_scene(preload("res://data/src/ui/splash_screen.tscn"))
