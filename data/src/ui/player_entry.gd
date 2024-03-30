extends Control

const ICON : PackedScene = preload("res://data/src/ui/player_list_icon.tscn")
var player_num : int = 0

func _ready():
	var icon_instance = ICON.instantiate()
	icon_instance.set_data(player_num)
	%SubViewport.add_child(icon_instance)

func set_data(_player_num : int, player_power : int):
	player_num = _player_num
	%Label.text = str(player_power)
