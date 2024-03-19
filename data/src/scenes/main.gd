extends Node3D

func _process(delta):
	handle_input()

func handle_input():
	if Input.is_action_just_pressed("my_cycle_next"):
		%MainScene.apply_perspective(1)
	if Input.is_action_just_pressed("my_cycle_prev"):
		%MainScene.apply_perspective(-1)
	if Input.is_action_just_pressed("my_cycle_center"):
		pass
