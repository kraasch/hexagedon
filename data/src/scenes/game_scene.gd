extends Node3D

func _ready():
	# for debugging. # TODO: remove later.
	%BallCenter.position = CP
	%BallZ.position = Vector3(0,0,5)
	%BallX.position = Vector3(5,0,0)
	# setup ui.
	%SettingsButton.pressed.connect(self.settings_button_pressed)
	%PreviousView.pressed.connect(self.previous_perspective)
	%ResetView.pressed.connect(self.reset_perspective)
	%NextView.pressed.connect(self.next_perspective)
	%FreelookView.pressed.connect(%FreeCam.free_cam)
	%EndButton.pressed.connect(self.exit_button_pressed)
	# setup intial perspective
	apply_perspective(0)

func _input(event):
	if event.is_action_pressed("my_cycle_next"):
		next_perspective()
	if event.is_action_pressed("my_cycle_prev"):
		previous_perspective()
	if event.is_action_pressed("my_cycle_center"):
		reset_perspective()

func settings_button_pressed():
	pass # TODO: implement; overlay menu.

func exit_button_pressed():
	BackgroundMusicManager.transition_to_menu_music()
	SceneManager.set_scene(preload("res://data/src/ui/end_screen.tscn"))

func next_perspective():
	apply_perspective(1)

func previous_perspective():
	apply_perspective(-1)

func reset_perspective():
	apply_perspective(0)

# Look at the grid from different perspectives, with O = origin of array at (0,0).
#    .y
#   /
#  +-------------------> x
#  |        N
#  |   [O][ ][ ][ ]
#  |    [ ][ ][ ]
#  | W [ ][ CP ][ ] E
#  |    [ ][ ][ ]
#  |   [ ][ ][ ][ ]
#  |        S
#  v
#  z

var   DIM : float   = 2.0
var   CP  : Vector3 = Vector3(DIM, 0, DIM) # center point. TODO: change this depending on map dimensions.

const HO  : float   =  10.0                                # height offset (over the ground).
var   N   : Vector3 = Vector3(CP.x * 1.0, HO, CP.z * 0.0) # perspective from north.
var   S   : Vector3 = Vector3(CP.x * 1.0, HO, CP.z * 2.0) # perspective from south.
var   E   : Vector3 = Vector3(CP.x * 2.0, HO, CP.z * 1.0) # perspective from east.
var   W   : Vector3 = Vector3(CP.x * 0.0, HO, CP.z * 1.0) # perspective from west.
var   T   : Vector3 = Vector3(CP.x * 1.0, HO, CP.z * 1.0) # perspective from top.
var   PERSPECTIVES       : Array = [ N, E, S, W ]
var   PERSPECTIVES_NAMES : Array = [ 'N', 'E', 'S', 'W' ]

var current_perspctive_index : int = 0

# NOTE: if choosing top-down perspective then the current_perspctive_index is 
#       out of sync with the PERSPECTIVES array.
func apply_perspective(step : int):
	var perspctives_max : int = len(PERSPECTIVES)
  # default case (step == 0) means to switch to top down.
	var new_index : int = 0
	var location : Vector3 = T
	if step != 0:
		# if index is -1 or 1 switch to next perspective.
		new_index = (current_perspctive_index + step) % perspctives_max
		location = PERSPECTIVES[new_index]
	%FreeCam.update(location, CP)
	# increment index.
	current_perspctive_index = new_index
