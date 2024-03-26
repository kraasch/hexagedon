extends Node

# TODO: implement proper SFX queue.

var sfx_player : AudioStreamPlayer = AudioStreamPlayer.new()
var root       : Node = null
var is_setup   : bool = false

# TODO: implement.
var EFFECT_NAMES : Array = [
	'abc',
]

func update_mute_state():
	if Globals.IS_AUDIO_MUTE:
		sfx_player.stop()
	# TODO: resume audio.

func init_manager(_root : Node) -> void:
	root = _root

func setup() -> void:
	if not is_setup:
		sfx_player.autoplay = false
		root.add_child(sfx_player)
		var sfx_track : String = 'abc'
		var mp3 : AudioStreamMP3 = Helpers.load_mp3(sfx_track)
		sfx_player.set_stream(mp3)
		# toggle setup flag.
		is_setup = true

func queue_effect(effect_name : String) -> void:
	setup()
	pass # TODO: implement.
