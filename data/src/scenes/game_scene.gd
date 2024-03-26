extends Node3D

func _ready():
	%SoundButton.pressed.connect(self.sound_button_pressed)
	%SettingsButton.pressed.connect(self.settings_button_pressed)
	%PreviousView.pressed.connect(self.previous_perspective)
	%ResetView.pressed.connect(self.reset_perspective)
	%NextView.pressed.connect(self.next_perspective)
	%EndButton.pressed.connect(self.exit_button_pressed)

func _input(event):
	if event.is_action_pressed("my_cycle_next"):
		next_perspective()
	if event.is_action_pressed("my_cycle_prev"):
		previous_perspective()
	if event.is_action_pressed("my_cycle_center"):
		reset_perspective()

func sound_button_pressed():
	Globals.toggle_mute()
	BackgroundMusicManager.update_mute_state()
	SfxQueueManager.update_mute_state()
	# update icon.
	if Globals.IS_AUDIO_MUTE:
		%SoundButton.icon = preload("res://data/assets/icons/muted.png")
	else:
		%SoundButton.icon = preload("res://data/assets/icons/speaker.png")

func settings_button_pressed():
	pass # TODO: implement; overlay menu.

func exit_button_pressed():
	BackgroundMusicManager.transition_to_menu_music()
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
	%FreeCam.position.x = location.x
	%FreeCam.position.y = location.y
	%FreeCam.position.z = location.z
	%FreeCam.rotation.x = orientation.x
	%FreeCam.rotation.y = orientation.y
	%FreeCam.rotation.z = orientation.z
	# increment index.
	current_perspctive_index = new_index
