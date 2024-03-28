extends CanvasLayer

func _on_color_rect_gui_input(event):
	if event.is_action_pressed('my_left_click'):
		pass
#		SceneManager.set_scene(preload("res://data/src/ui/main_menu.tscn"))
		get_tree().quit() # TODO: remove later (for now quit the game here).
