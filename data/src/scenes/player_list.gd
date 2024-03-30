extends CanvasLayer

const HEX_TILE     : PackedScene = preload("res://data/src/scenes/field.tscn")

func _ready() -> void:
	var group_data = MapGenerator.group_data
	var group_grid = MapGenerator.group_grid
	var players_num : int = MapGenerator.number_of_players()
	var powers : Dictionary = MapGenerator.player_power_list()
	var msg : String = ''  
	for i in range(players_num):
		var player_num : int = i + 1
		msg = msg + str(player_num) + ': ' + str(powers[player_num]) + ', '
	%TempLabel.text = msg
#	var tile = HEX_TILE.instantiate()
#	tile.set_data(player_num, 1, 1, false)
#	%SceneBuffer.add_child(tile)
#	tile.translate(Vector3(0, 0, 0))
