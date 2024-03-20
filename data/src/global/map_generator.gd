@tool
extends Node

var party_grid  : Array = []
var group_grid  : Array = []
var parties_num : int = 0
var groups_num  : int = 0

func create_new_map_simple():
	# provide default map.
	party_grid = [
		[1, 1, 2, 0],
		[1, 0, 2, 2],
		[2, 2, 0, 3],
		[2, 2, 3, 0],
	]
	parties_num = 3
	group_grid = [
		[1, 1, 3, 0],
		[1, 0, 3, 3],
		[2, 2, 0, 4],
		[2, 2, 4, 0],
	]
	groups_num = 4

func create_new_map(width : int = 0, height : int = 0):
	# create full grid.
	var new_map = []
	for x in range(height):
		var map_line = []
		for y in range(width):
			var type_index : int = ColorGenerator.rand_num()
			map_line.push_back(type_index)
		new_map.push_back(map_line)
	party_grid = new_map

func get_party_grid():
	return party_grid

func get_group_grid():
	return group_grid
