extends Node3D

# TODO: call SceneManager from here.
var SPLASH : PackedScene = preload("res://data/src/ui/splash_screen.tscn")

func _ready():
	SceneManager.set_scene_root(%ActiveSceneContainer)
	SceneManager.set_scene(SPLASH)
