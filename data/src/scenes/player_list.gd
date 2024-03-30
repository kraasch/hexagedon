extends Node

const ENTRY : PackedScene = preload("res://data/src/ui/player_entry.tscn")

func _ready() -> void:
	var group_data = MapGenerator.group_data
	var group_grid = MapGenerator.group_grid
	var players_num : int = MapGenerator.number_of_players()
	var powers : Dictionary = MapGenerator.player_power_list()
	var msg : String = ''  
	for i in range(players_num):
		var player_num : int = i + 1
		var player_power : int = powers[player_num]
		var entry = ENTRY.instantiate()
		entry.set_data(player_num, player_power)
		%PlayerContainer.add_child(entry)
