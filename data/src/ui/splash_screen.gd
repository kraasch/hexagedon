extends CanvasLayer

# TODO: keep label centered in center container even if screen is resized.

func _on_color_rect_gui_input(event):
	if event.is_action_pressed('my_left_click'):
		SceneManager.set_scene(preload("res://data/src/ui/main_menu.tscn"))
