extends Node3D

func _ready():
	# setup globals.
	SfxQueueManager.init_manager(%GlobalRoot)
	BackgroundMusicManager.init_manager(%GlobalRoot)
	SceneManager.set_scene_root(%ActiveSceneContainer)
	# setup mute button.
	AudioManager.master_mute_changed.connect(self.update_icon)
	%SoundButton.pressed.connect(self.sound_button_pressed)
	update_icon()
	# setup first scene.
	BackgroundMusicManager.transition_to_menu_music()
	SceneManager.set_scene(preload("res://data/src/ui/splash_screen.tscn"))

func sound_button_pressed() -> void:
	AudioManager.toggle_mute(AudioManager.MASTER_BUS)

func update_icon() -> void:
	if AudioManager.is_muted(AudioManager.MASTER_BUS):
		%SoundButton.icon = preload("res://data/assets/icons/muted.png")
	else:
		%SoundButton.icon = preload("res://data/assets/icons/speaker.png")
