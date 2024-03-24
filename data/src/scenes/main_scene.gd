extends Node3D

func _ready():
	%EndButton.pressed.connect(self.exit_button_pressed)
	%PreviousView.pressed.connect(self.previous_perspective)
	%NextView.pressed.connect(self.next_perspective)
	%ResetView.pressed.connect(self.reset_perspective)

func _input(event):
	if event.is_action_just_pressed("my_cycle_next"):
		next_perspective()
	if event.is_action_just_pressed("my_cycle_prev"):
		previous_perspective()
	if event.is_action_just_pressed("my_cycle_center"):
		reset_perspective()

func exit_button_pressed():
	SceneManager.set_scene(preload("res://data/src/ui/end_screen.tscn"))

func next_perspective():
	apply_perspective(1)

func previous_perspective():
	apply_perspective(-1)

func reset_perspective():
	apply_perspective(0)

const PERSPECTIVES : Array = [
	[ Vector3(4, 4, 11), Vector3(-44.8,   0, 0) ],
	[ Vector3(4, 4, -2), Vector3(-44.8, 210.5, 0) ],
	[ Vector3(4, 6, 4), Vector3(-90, 90, 180) ],
]

var current_perspctive_index : int = 0
var perspctives_max : int = len(PERSPECTIVES)

func apply_perspective(step : int):
	if step == 0:
		current_perspctive_index = 0
	var new_index : int = (current_perspctive_index + step) % perspctives_max
	var new_perspective = PERSPECTIVES[new_index]
	var location = new_perspective[0]
	var orientation = new_perspective[1]
	# set values.
	%Camera3D.position.x = location.x
	%Camera3D.position.y = location.y
	%Camera3D.position.z = location.z
	%Camera3D.rotation.x = orientation.x
	%Camera3D.rotation.y = orientation.y
	%Camera3D.rotation.z = orientation.z
	# increment index.
	current_perspctive_index = new_index
