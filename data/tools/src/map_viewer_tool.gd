@tool
extends Node3D

func _ready():
	%UpdateButton.pressed.connect(self._button_pressed)
	%PartySliderDisplay.set_data('Number of parties', 1, 10, Globals.NUM_OF_PARTIES)
	%GridSizeSliderDisplay.set_data('Grid size', 1, 30, Globals.GRID_SIZE)
	%StackHeightSliderDisplay.set_data('Stack height', 0, 12, Globals.MAX_STACK_HEIGHT)
	%CubeSizeSliderDisplay.set_data('Cube size', 0.05, 0.5, Globals.CUBE_SIZE, 0.05)

var rng = RandomNumberGenerator.new()
func _button_pressed():
	Globals.NUM_OF_PARTIES     = %PartySliderDisplay.val
	Globals.GRID_SIZE          = %GridSizeSliderDisplay.val
	Globals.MAX_STACK_HEIGHT   = %StackHeightSliderDisplay.val
	Globals.CUBE_SIZE          = %CubeSizeSliderDisplay.val
	%HexGrid.generate_grid()
	# TODO: make an animated translate from old to new cam position here.
	%Cam.global_position.z = %GridSizeSliderDisplay.val / 2

func _input(event):
	if event.is_action_pressed('my_left_click'):
		shoot_ray()

func shoot_ray():
	var mouse_position = get_viewport().get_mouse_position()
	var ray_length = 1000
	var from = %Cam.project_ray_origin(mouse_position)
	var to = from + %Cam.project_ray_normal(mouse_position) * ray_length
	var worldspace = get_world_3d().direct_space_state
	var ray_query = PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	var raycast_result = worldspace.intersect_ray(ray_query)
	print(raycast_result)
