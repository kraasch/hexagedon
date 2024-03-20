@tool
extends Node3D

func _ready():
	%UpdateButton.pressed.connect(self._button_pressed)
	%PartySliderDisplay.set_data('Number of parties', 1, 10, Globals.MAX_NUM_OF_PARTIES)
	%GridSizeSliderDisplay.set_data('Grid size', 1, 30, Globals.MAX_GRID_SIZE)
	%StackHeightSliderDisplay.set_data('Stack height', 0, 12, Globals.MAX_STACK_HEIGHT)
	%CubeSizeSliderDisplay.set_data('Cube size', 0.05, 0.5, Globals.CUBE_SIZE, 0.05)

var rng = RandomNumberGenerator.new()
func _button_pressed():
	Globals.MAX_NUM_OF_PARTIES = %PartySliderDisplay.val
	Globals.MAX_GRID_SIZE      = %GridSizeSliderDisplay.val
	Globals.MAX_STACK_HEIGHT   = %StackHeightSliderDisplay.val
	Globals.CUBE_SIZE          = %CubeSizeSliderDisplay.val
	%HexGrid.new_map()
	# TODO: make an animated translate from old to new cam position here.
	%Cam.global_position.z = %GridSizeSliderDisplay.val / 2
