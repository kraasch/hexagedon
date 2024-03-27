extends Camera3D

# TODO: free mouse when scene is unloaded.

var is_locked         : bool    = false
var is_boost          : bool    = false
var acceleration      : float   = 30
var move_speed        : float   = 8
var mouse_speed       : float   = 300 # TODO: make this a global setting.
var move_boost_factor : float   = 2.0
var look_angles       : Vector2 = Vector2.ZERO
var last_look_angles  : Vector2 = Vector2.ZERO
var velocity          : Vector3 = Vector3.ZERO

func _process(delta):
	if not is_locked:
		look_angles.y = clamp(look_angles.y, PI / -2, PI / 2)
		set_rotation(Vector3(look_angles.y, look_angles.x, 0))
		var direction = update_cam_direction()
		if direction.length_squared() > 0:
			velocity += direction * acceleration * delta
		var move_speed_boosted = get_boost()
		velocity *= move_speed_boosted
		if velocity.length() > move_speed * move_speed_boosted:
			velocity = velocity.normalized() * move_speed * move_speed_boosted
		translate(velocity * delta) # apply velocity to camera node.

func get_boost():
	if Input.is_action_pressed('my_boost'):
		return move_boost_factor
	return 1.0

func update_cam_direction():
	var dir = Vector3()
	if Input.is_action_pressed('my_move_forward'):
		dir += Vector3.FORWARD
	if Input.is_action_pressed('my_move_back'):
		dir += Vector3.BACK
	if Input.is_action_pressed('my_move_left'):
		dir += Vector3.LEFT
	if Input.is_action_pressed('my_move_right'):
		dir += Vector3.RIGHT
	if Input.is_action_pressed('my_move_up'):
		dir += Vector3.UP
	if Input.is_action_pressed('my_move_down'):
		dir += Vector3.DOWN
	if dir == Vector3.ZERO:
		velocity = Vector3.ZERO
	return dir.normalized()

func toggle_cam():
	if is_locked:
		free_cam()
	else:
		lock_cam()

func update(location : Vector3, target : Vector3):
	self.position = location
	look_at(target)
	# update last_look_angles to match the new orientation.
	update_look_angles()

func update_look_angles():
	pass
#	look_angles = Vector2(1.0, 1.0) # TODO: implement.

func reset_look_angles():
	look_angles = last_look_angles

func capture_look_angles():
	last_look_angles = look_angles

func lock_cam():
	capture_look_angles()
	is_locked = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

# TODO: in the web version, get the mouse JavaScript mouse pointer back.
func free_cam():
	reset_look_angles()
	is_locked = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _ready():
	lock_cam()

func _input(event):
	if event.is_action_pressed('my_boost'):
		is_boost = true
	else:
		is_boost = false
	if event.is_action_pressed('my_confirm'):
		toggle_cam()
	if event is InputEventMouseMotion:
		look_angles -= event.relative / mouse_speed
