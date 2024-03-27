extends Node

# TODO: set default audio volume.
# TODO: allow user to set audio volume.
# TODO: allow user to mute songs.
# TODO: manage fade in and fade out.

var   is_setup           : bool              = false
var   root               : Node              = null
var   menu_player        : AudioStreamPlayer = AudioStreamPlayer.new()
var   game_player        : AudioStreamPlayer = AudioStreamPlayer.new()
var   last_active_player : AudioStreamPlayer = null
var   BUS_NAME           : String            = AudioManager.MUSIC_BUS


# load all songs from dedicated directory.
const main_track_path    : String            = "res://data/assets/soundtrack/00_main.mp3"

# load all songs from dedicated directory.
const soundtrack_paths   : Array             = [
	"res://data/assets/soundtrack/01_anttis-instrumentals+happy-thingies.mp3",
	"res://data/assets/soundtrack/02_anttis-instrumentals+hrdelli.mp3",
	"res://data/assets/soundtrack/03_anttis-instrumentals+hysteria-in-the-jungle.mp3"
]

func resume_playing():
	if last_active_player != null:
		pass
		last_active_player.play()

func init_manager(_root : Node):
	root = _root

func setup():
	if not is_setup and root != null:
		# set the bus for each player.
		menu_player.bus = BUS_NAME
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
