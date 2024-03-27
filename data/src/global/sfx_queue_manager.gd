extends Node

var root        : Node              = null
var is_setup    : bool              = false
var BUS_NAME    : String            = AudioManager.SFX_BUS
var SFX_PLAYERS : Dictionary        = {}

const EFFECTS_DIR : String = 'res://data/assets/effects/'
const EFFECTS_ENDING : String = '.wav'
const EFFECT_NAMES : Array = [ # TODO: read every file into this array from dedicated directory.
	'button',
	'draw_lost',
	'draw_win',
	'game_over',
	'game_win',
]
const MIN_INDEX    : int = 0
const MAX_INDEX    : int = 4

const BUTTON_CLICK : int = MIN_INDEX + 0
const MOVE_LOST    : int = MIN_INDEX + 1
const MOVE_WIN     : int = MIN_INDEX + 2
const GAME_LOST    : int = MIN_INDEX + 3
const GAME_WIN     : int = MIN_INDEX + 4

func get_effect_path(effect_index : int) -> String:
	return EFFECTS_DIR + EFFECT_NAMES[effect_index] + EFFECTS_ENDING

func init_manager(_root : Node) -> void:
	root = _root

func load_wav(path : String) -> AudioStreamWAV:
	var file : FileAccess = FileAccess.open(path, FileAccess.READ)
	var sound : AudioStreamWAV = AudioStreamWAV.new()
	sound.data = file.get_buffer(file.get_length())
	return sound

func setup() -> void:
	if not is_setup:
		for effect_index in range(len(EFFECT_NAMES)):
			var effect_name : String = EFFECT_NAMES[effect_index]
			var sfx_player : AudioStreamPlayer = AudioStreamPlayer.new()
			sfx_player.bus = BUS_NAME
			sfx_player.autoplay = false
			root.add_child(sfx_player)
			var wav : AudioStreamWAV = load_wav(get_effect_path(effect_index))
			sfx_player.set_stream(wav)
			SFX_PLAYERS[effect_name] = sfx_player
		# toggle setup flag.
		is_setup = true

# TODO: implement proper SFX queue.
func queue_effect(effect_index : int) -> void:
	setup()
	play_effect(effect_index)

func play_effect(effect_index : int) -> void:
	if effect_index >= MIN_INDEX and effect_index <= MAX_INDEX:
		var effect_name : String = EFFECT_NAMES[effect_index]
		var player : AudioStreamPlayer = SFX_PLAYERS[effect_name]
		player.play()
