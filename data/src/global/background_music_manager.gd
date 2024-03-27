extends Node

# TODO: manage fade in and fade out.

var   is_setup           : bool              = false
var   root               : Node              = null
var   menu_player        : AudioStreamPlayer = AudioStreamPlayer.new()
var   game_player        : AudioStreamPlayer = AudioStreamPlayer.new()
var   last_active_player : AudioStreamPlayer = null
var   BUS_NAME           : String            = AudioManager.MUSIC_BUS

const GAME_MUSIC_DIR  : String = "res://data/assets/soundtrack/game"
const MENU_MUSIC_DIR  : String = "res://data/assets/soundtrack/menu"

func resume_playing():
	if last_active_player != null:
		last_active_player.play()

func init_manager(_root : Node):
	root = _root

func make_randomizer_from_path(path : String) -> AudioStreamRandomizer:
	var streamRandomizer : AudioStreamRandomizer = AudioStreamRandomizer.new()
	const MP3_FILE_ENDING : String = '.mp3'
	const APPEND : int = -1
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.to_lower().ends_with(MP3_FILE_ENDING):
					var file_path : String = path + '/' + file_name
					streamRandomizer.add_stream(APPEND, Helpers.load_mp3(file_path))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return streamRandomizer

func setup():
	if not is_setup and root != null:
		# set the bus for each player.
		menu_player.bus = BUS_NAME
		# setup players.
		menu_player.autoplay = false
		game_player.autoplay = false
		root.add_child(menu_player)
		root.add_child(game_player)
		# infinitely loop.
		menu_player.finished.connect(resume_playing)
		game_player.finished.connect(resume_playing)
		# add music tracks.
		menu_player.set_stream(make_randomizer_from_path(MENU_MUSIC_DIR))
		game_player.set_stream(make_randomizer_from_path(GAME_MUSIC_DIR))
		# mark as started.
		is_setup = true

func transition_to_game_music():
	last_active_player = game_player
	setup()
	menu_player.stop()
	game_player.play()

func transition_to_menu_music():
	last_active_player = menu_player
	setup()
	game_player.stop()
	menu_player.play()
