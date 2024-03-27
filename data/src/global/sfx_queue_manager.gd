extends Node

# TODO: implement proper SFX queue.

var sfx_player : AudioStreamPlayer = AudioStreamPlayer.new()
var root       : Node              = null
var is_setup   : bool              = false
const BUS_NAME : String            = AudioManager.SFX_BUS

# TODO: implement.
var EFFECT_NAMES : Array = [
	'abc',
]
const TRACK    : String            = "res://data/assets/soundtrack/00_main.mp3"

func init_manager(_root : Node) -> void:
	root = _root

func setup() -> void:
	if not is_setup:
		sfx_player.bus = BUS_NAME
		sfx_player.autoplay = false
		root.add_child(sfx_player)
		var mp3 : AudioStreamMP3 = Helpers.load_mp3(TRACK)
		sfx_player.set_stream(mp3)
		# toggle setup flag.
		is_setup = true

func queue_effect(effect_name : String) -> void:
	setup()
	pass # TODO: implement.
