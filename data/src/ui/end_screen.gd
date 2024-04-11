extends CanvasLayer

func _on_color_rect_gui_input(event):
	if event.is_action_pressed('my_left_click'):
		SceneManager.set_scene(load("res://data/src/ui/main_menu.tscn"))
		# TODO: properly unload all previous game state and objects.
