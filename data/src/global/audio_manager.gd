extends Node

# NOTE: this class wraps around Godot's AudioServer and also around my custom 
#       bus layout and the therein defined bus names (file of definition can be 
#       found at res://data/src/misc).

# TODO: allow in-game menu to mute only sound effect or music bus.

const MUSIC_BUS  : String = 'Music'
const MASTER_BUS : String = 'Master'
const SFX_BUS    : String = 'SFX'

func _ready():
	decrease_volume_master()

func is_muted(bus_name : String):
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	return AudioServer.is_bus_mute(bus_index)

func is_muted_master():
	return is_muted(MASTER_BUS)

func toggle_mute_master():
	var bus_index : int = AudioServer.get_bus_index(MASTER_BUS)
	var current_state : bool = AudioServer.is_bus_mute(bus_index)
	AudioServer.set_bus_mute(bus_index, not current_state)

func decrease_volume_master():
	var bus_index : int = AudioServer.get_bus_index(MASTER_BUS)
	AudioServer.set_bus_volume_db(bus_index, Globals.AUDIO_VOLUME)
