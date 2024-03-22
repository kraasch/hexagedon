extends CanvasLayer

# TODO: keep label centered in center container even if screen is resized.

# TODO: extract a global screen-manager class.
const MAIN_MENU : PackedScene = preload("res://data/src/ui/main_menu.tscn")
#const VIEWER : PackedScene = preload("res://data/tools/src/map_viewer_tool.tscn")
#const MAIN : PackedScene = preload("res://data/tools/src/main.tscn")
func _input(event):
	if Input.is_action_pressed('my_left_click'):
		var main = MAIN_MENU.instantiate()
		$"../..".add_child(main)
		self.queue_free()
