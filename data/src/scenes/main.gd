extends Node3D

func _ready():
	# setup globals.
	SfxQueueManager.init_manager(%GlobalRoot)
	BackgroundMusicManager.init_manager(%GlobalRoot)
	SceneManager.set_scene_root(%ActiveSceneContainer)
	# setup mute button.
	%SoundButton.pressed.connect(self.sound_button_pressed)
	%SoundButton.icon = preload("res://data/assets/icons/muted.png")
	# setup first scene.
	BackgroundMusicManager.transition_to_menu_music()
	SceneManager.set_scene(preload("res://data/src/ui/splash_screen.tscn"))

func sound_button_pressed():
	AudioManager.toggle_mute_master()
	# update icon.
	if AudioManager.is_muted_master():
		%SoundButton.icon = preload("res://data/assets/icons/muted.png")
	else:
		%SoundButton.icon = preload("res://data/assets/icons/speaker.png")
