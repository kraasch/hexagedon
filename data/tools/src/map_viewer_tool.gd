@tool
extends Node3D

func _ready():
	%UpdateButton.pressed.connect(self._button_pressed)

func _button_pressed():
	print("Hello world!")
