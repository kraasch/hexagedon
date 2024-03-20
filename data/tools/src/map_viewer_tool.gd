@tool
extends Node3D

func _ready():
	%UpdateButton.pressed.connect(self._button_pressed)
	%PartySlider.value_changed.connect(self._party_slider_updated)
	_party_slider_updated(null)

func _button_pressed():
	Globals.MAX_NUM_OF_PARTIES = %PartySlider.value
	%HexGrid.new_map()

func _party_slider_updated(value):
	%PartyNum.text = str(%PartySlider.value)
