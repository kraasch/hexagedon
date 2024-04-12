extends Node

var rng = RandomNumberGenerator.new()
var size   : int = 30
var width  : int = size
var height : int = size
var threshold : float = 0.6
var zoom : int = 5
@export var n : FastNoiseLite

func _ready():
	n.seed = rng.randi_range(0, 1000)
	for x in range(width):
		var line = ''
		for y in range(height):
			var xx : int = x * zoom
			var yy : int = y * zoom
			var cell = n.get_noise_2d(xx, yy)
			if abs(cell) > threshold:
				line += 'x'
			else:
				line += ' '
		print(line)
