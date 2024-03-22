extends CanvasLayer

# TODO: keep label centered in center container even if screen is resized.

# TODO: extract a global screen-manager class.

const MAIN : PackedScene = preload("res://data/src/scenes/main_scene.tscn")
const VIEWER : PackedScene = preload("res://data/tools/src/map_viewer_tool.tscn")

func _input(event):
	if Input.is_action_pressed('my_left_click'):
		var main = VIEWER.instantiate()
		$"../..".add_child(main)
		self.queue_free()
