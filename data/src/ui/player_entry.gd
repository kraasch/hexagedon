extends Control

const ICON : PackedScene = preload("res://data/src/ui/player_list_icon.tscn")
var player_num : int = 0
var icon_instance = null

func _ready():
	var icon_instance = ICON.instantiate()
	icon_instance.set_data(player_num)
	self.icon_instance = icon_instance
	%SubViewport.add_child(icon_instance)

func set_data(_player_num : int, player_power : int):
	player_num = _player_num
	%Label.text = str(player_power)

func set_mark(is_visible : bool):
	if icon_instance != null:
		icon_instance.set_mark(is_visible)
