extends Node

const ENTRY : PackedScene = preload("res://data/src/ui/player_entry.tscn")
var entries : Array = []

func _ready() -> void:

	# variables.
	var players_num       : int        = MapGenerator.number_of_players()
	var powers            : Dictionary = MapGenerator.player_power_list()
	var active_player_num : int        = MatchOrchestrator.active_player

	# setup player list bar.
	for i in range(players_num):
		var player_num : int = i + 1
		var player_power : int = powers[player_num]
		var entry = ENTRY.instantiate()
		entries.push_back(entry)
		entry.set_data(player_num, player_power)
		%PlayerContainer.add_child(entry)

	# mark the active player.
	set_mark(active_player_num)

func set_mark(index : int):
	if index >= 0 and index < len(entries):
		for i in range(len(entries)):
			entries[i].set_mark(i == index)
