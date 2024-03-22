extends Node

var active = null
var root_scene = null

func set_scene_root(_root_scene):
	root_scene = _root_scene

func set_scene(scene : PackedScene):
	var instance = scene.instantiate()
	remove_old_scene()
	root_scene.add_child(instance)
	active = instance

func remove_old_scene():
	if active != null:
		active.queue_free()
