@tool
extends Node3D

func _ready():
	%UpdateButton.pressed.connect(self._button_pressed)
	%PartySliderDisplay.set_data('Number of parties', 1, 6, Globals.MAX_NUM_OF_PARTIES)
	%GridSizeSliderDisplay.set_data('Grid size', 1, 30, Globals.MAX_GRID_SIZE)

func _button_pressed():
	print('grid size new: ' + str(%GridSizeSliderDisplay.val))
	Globals.MAX_NUM_OF_PARTIES = %PartySliderDisplay.val
	Globals.MAX_GRID_SIZE      = %GridSizeSliderDisplay.val
	%HexGrid.new_map()
	# TODO: make an animated translate from old to new cam position here.
	%Cam.global_position.z = %GridSizeSliderDisplay.val / 4
