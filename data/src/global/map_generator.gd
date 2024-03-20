@tool
extends Node

func create_new_map(width : int = 0, height : int = 0):

	# provide default map.
	if width == 0 and height == 0:
		var default_map = [
		[1, 1, 3, 0],
		[1, 0, 3, 3],
		[2, 2, 0, 1],
		[0, 2, 1, 0],
		]
		return default_map

	# create full grid.
	var map = []
	for x in range(height):
		var map_line = []
		for y in range(width):
			var type_index : int = ColorGenerator.rand_num()
			map_line.push_back(type_index)
		map.push_back(map_line)
	return map
