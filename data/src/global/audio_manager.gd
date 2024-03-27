extends Node

# NOTE: this class wraps around Godot's AudioServer and also around my custom 
#       bus layout and the therein defined bus names (file of definition can be 
#       found at res://data/src/misc).

# TODO: allow in-game menu to mute only sound effect or music bus.

const MASTER_BUS : String = 'Master'
const MUSIC_BUS  : String = 'Music'
const SFX_BUS    : String = 'SFX'
const MIN_MUTE_VOLUME : float = 0.06

func _ready():
	set_volume(MASTER_BUS, Globals.INITIAL_VOLUME)
	set_volume(MUSIC_BUS,  Globals.INITIAL_VOLUME)
	set_volume(SFX_BUS,    Globals.INITIAL_VOLUME)
	toggle_mute_master()

func is_muted(bus_name : String) -> bool:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	return AudioServer.is_bus_mute(bus_index)

func is_muted_master() -> bool:
	return is_muted(MASTER_BUS)

func toggle_mute_master() -> void:
	toggle_mute(MASTER_BUS)

func toggle_mute(bus_name : String) -> void:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	var current_state : bool = AudioServer.is_bus_mute(bus_index)
	AudioServer.set_bus_mute(bus_index, not current_state)

func mute_bus(bus_name : String) -> void:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_mute(bus_index, false)

func get_volume(bus_name : String) -> float:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	var volume : float = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	return volume

func set_volume(bus_name : String, linear_volume : float) -> void:
	print('hi there')
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(linear_volume))
	if linear_volume < MIN_MUTE_VOLUME:
		mute_bus(bus_name)
