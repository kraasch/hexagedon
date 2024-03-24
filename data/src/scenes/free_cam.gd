extends Camera3D

# TODO: free mouse when scene is unloaded.

var acceleration : float = 30
var move_speed : float = 8
var mouse_speed : float = 300
var move_boost_factor : float = 2.0
var velocity = Vector3.ZERO
var look_angles = Vector2.ZERO
var is_locked : bool = false
var is_boost : bool = false

func _process(delta):
	if is_locked:
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

func _ready():
	is_locked = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event.is_action_pressed('my_boost'):
		is_boost = true
	else:
		is_boost = false
	if event.is_action_pressed('my_confirm'):
		if is_locked:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			is_locked = false
			# TODO: reset mouse to neutral position.
#			var center : Vector2 = get_viewport().get_visible_rect().size / 2.0
#			var center : Vector2 = get_viewport().size
#			get_viewport().warp_mouse(center)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_locked = true
	if event is InputEventMouseMotion:
		look_angles -= event.relative / mouse_speed
