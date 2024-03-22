extends CanvasLayer

func _input(event):
	if Input.is_action_pressed('my_left_click'):
		SceneManager.set_scene(preload("res://data/src/ui/main_menu.tscn"))
