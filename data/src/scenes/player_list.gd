extends Node

const ENTRY : PackedScene = preload("res://data/src/ui/player_entry.tscn")
var entries : Array = []

func _ready() -> void:

	# variables.
	var players_num  : int        = MapGenerator.number_of_players()
	var powers       : Dictionary = MapGenerator.player_power_list()

	# setup player list bar.
	for i in range(players_num):
		var player_num : int = i + 1
		var player_power : int = powers[player_num]
		var entry = ENTRY.instantiate()
		entries.push_back(entry)
		entry.set_data(player_num, player_power)
		%PlayerContainer.add_child(entry)
		# register in map-generator to receive signal in case player dies:
		MapGenerator.player_gone.connect(remove_player)

	# setup mark.
	MatchOrchestrator.active_player_changed.connect(self.update_mark)
	update_mark()

func remove_player(player_index : int):
	print('++++++++++++++++++++++++++++')
#	if len(entries) < player_index:
	entries[player_index].visible = false

# mark the active player.
func update_mark():
	var index : int = MatchOrchestrator.active_player_index
	if index >= 0 and index < len(entries):
		for i in range(len(entries)):
			entries[i].set_mark(i == index)
