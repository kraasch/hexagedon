@tool
extends Node3D

func _ready():
	%UpdateButton.pressed.connect(self._button_pressed)
	%PartySliderDisplay.set_data('Number of parties', 1, 6, 6)
	%GridSizeSliderDisplay.set_data('Grid size', 1, 30, 10)

func _button_pressed():
	Globals.MAX_NUM_OF_PARTIES = %PartySliderDisplay.val
	%HexGrid.new_map()
