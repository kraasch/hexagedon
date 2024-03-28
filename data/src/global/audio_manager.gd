extends Node

# NOTE: this class wraps around Godot's AudioServer and also around my custom 
#       bus layout and the therein defined bus names (file of definition can be 
#       found at res://data/src/misc).

# TODO: allow in-game menu to mute only sound effect or music bus.

signal master_mute_changed

const MASTER_BUS : String = 'Master'
const MUSIC_BUS  : String = 'Music'
const SFX_BUS    : String = 'SFX'

func _ready():
	set_volume(MASTER_BUS, Globals.INITIAL_VOLUME)
	set_volume(MUSIC_BUS,  Globals.INITIAL_VOLUME)
	set_volume(SFX_BUS,    Globals.INITIAL_VOLUME)

func is_muted(bus_name : String) -> bool:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	return AudioServer.is_bus_mute(bus_index)

func set_mute_bus(bus_name : String, do_mute : bool = true) -> void:
	print('mute volume of ' + bus_name + ' to :' + str(do_mute))
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_mute(bus_index, do_mute)
	# check if master was muted.
	if bus_name == MASTER_BUS:
		master_mute_changed.emit()

func toggle_mute(bus_name : String) -> void:
	set_mute_bus(bus_name, not is_muted(bus_name))

func get_volume(bus_name : String) -> float:
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	var volume : float = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	return volume

func set_volume(bus_name : String, linear_volume : float) -> void:
	print('set volume of ' + bus_name)
	var bus_index : int = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(linear_volume))
	if linear_volume < Globals.MIN_MUTE_VOLUME:
		set_mute_bus(bus_name, true)
	else:
		set_mute_bus(bus_name, false)
