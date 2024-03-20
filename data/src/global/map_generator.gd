@tool
extends Node

var party_map : Array = []
var group_map : Array = []

func create_new_map_simple():
	# provide default map.
	party_map = [
		[1, 1, 3, 0],
		[1, 0, 3, 3],
		[2, 2, 0, 1],
		[0, 2, 1, 0],
	]
	group_map = [
		[1, 1, 3, 0],
		[1, 0, 3, 3],
		[2, 2, 0, 4],
		[0, 2, 4, 0],
	]

func create_new_map(width : int = 0, height : int = 0):
	# create full grid.
	var new_map = []
	for x in range(height):
		var map_line = []
		for y in range(width):
			var type_index : int = ColorGenerator.rand_num()
			map_line.push_back(type_index)
		new_map.push_back(map_line)
	party_map = new_map

func get_party_grid():
	return party_map

func get_group_grid():
	return group_map
