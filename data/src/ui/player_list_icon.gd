extends Node3D

func set_data(player_num : int):
	%Mesh.material_override = ColorGenerator.get_shader(player_num)
