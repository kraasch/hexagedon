extends Node3D

const PERSPECTIVES : Array = [
	[ Vector3(4, 4, 11), Vector3(-44.8,   0, 0) ],
	[ Vector3(4, 4, -2), Vector3(-44.8, 210.5, 0) ],
	[ Vector3(4, 6, 4), Vector3(-90, 90, 180) ],
]

var perspctives_index : int = 0
var perspctives_max : int = len(PERSPECTIVES)

func apply_perspective(step : int):
	var new_perspective = PERSPECTIVES[perspctives_index]
	var location = new_perspective[0]
	var orientation = new_perspective[1]
	# set values.
	%Camera3D.position.x = location.x
	%Camera3D.position.y = location.y
	%Camera3D.position.z = location.z
	%Camera3D.rotation.x = orientation.x
	%Camera3D.rotation.y = orientation.y
	%Camera3D.rotation.z = orientation.z
	# increment index.
	perspctives_index = (perspctives_index + step) % perspctives_max
