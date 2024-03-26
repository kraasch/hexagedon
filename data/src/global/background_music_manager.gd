extends Node

# TODO: set default audio volume.
# TODO: allow user to set audio volume.
# TODO: allow user to mute songs.
# TODO: manage fade in and fade out.

var root : Node = null
const main_track_path : String = "res://data/assets/soundtrack/00_main.mp3"
const soundtrack_paths : Array = [
	"res://data/assets/soundtrack/01_anttis-instrumentals+happy-thingies.mp3",
	"res://data/assets/soundtrack/02_anttis-instrumentals+hrdelli.mp3",
	"res://data/assets/soundtrack/03_anttis-instrumentals+hysteria-in-the-jungle.mp3"
]
var menu_player : AudioStreamPlayer = AudioStreamPlayer.new()
var game_player : AudioStreamPlayer = AudioStreamPlayer.new()
var is_setup : bool = false

func update_mute_state():
	if Globals.IS_AUDIO_MUTE:
		menu_player.stop()
		game_player.stop()
	# TODO: resume audio.

func init_manager(_root : Node):
	root = _root

func setup():
	if not is_setup and root != null:
		# setup players.
		menu_player.autoplay = false
		game_player.autoplay = false
		root.add_child(menu_player)
		root.add_child(game_player)
		# add main menu track.
		var mp3 : AudioStreamMP3 = Helpers.load_mp3(main_track_path)
		menu_player.set_stream(mp3)
		# add game music tracks.
		var streamRandomizer : AudioStreamRandomizer = AudioStreamRandomizer.new()
		const APPEND : int = -1
		for i in range(len(soundtrack_paths)):
			streamRandomizer.add_stream(APPEND, Helpers.load_mp3(soundtrack_paths[i]))
		game_player.set_stream(streamRandomizer)
		# mark as started.
		is_setup = true

func transition_to_game_music():
	setup()
	menu_player.stop()
	game_player.play()

func transition_to_menu_music():
	setup()
	game_player.stop()
	menu_player.play()
