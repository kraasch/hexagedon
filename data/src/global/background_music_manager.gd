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
var is_started : bool = false

func load_mp3(path : String) -> AudioStreamMP3:
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	var sound : AudioStreamMP3 = AudioStreamMP3.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

func init_manager(_root : Node):
	root = _root

func start():
	if not is_started:
		# setup players.
		menu_player.autoplay = false
		game_player.autoplay = false
		root.add_child(menu_player)
		root.add_child(game_player)
		# add main menu track.
		var mp3 : AudioStreamMP3 = load_mp3(main_track_path)
		menu_player.set_stream(mp3)
		# add game music tracks.
		var streamRandomizer : AudioStreamRandomizer = AudioStreamRandomizer.new()
		const APPEND : int = -1
		for i in range(len(soundtrack_paths)):
			streamRandomizer.add_stream(APPEND, load_mp3(soundtrack_paths[i]))
		game_player.set_stream(streamRandomizer)
		# mark as started.
		is_started = true

func transition_to_game_music():
	start()
	menu_player.stop()
	game_player.play()

func transition_to_menu_music():
	start()
	game_player.stop()
	menu_player.play()
