extends FreeLookCamera

var dir := Vector3.ZERO
var vel := Vector3.ZERO


func _ready() -> void:
	dspeed = 10


func _physics_process(delta:float) -> void:
	_update_look()
	_update_move(delta)


func _update_look() -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	var rel = _mouse_position * sensitivity
	_mouse_position = Vector2.ZERO

	var parent := get_parent()
	if not parent is PhysicsBody3D:
		return

	var yaw = rel.x
	var pitch = rel.y

	var pitch_lim = clamp(
		pitch,
		-360 - _total_pitch,
		360.0 - _total_pitch
	)

	_total_pitch += pitch_lim

	parent.rotate_y(deg_to_rad(-yaw))
	parent.rotate_object_local(
		Vector3.RIGHT,
		deg_to_rad(-pitch_lim)
	)


func _update_move(_delta:float) -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return
	var parent := get_parent()
	if not parent is PhysicsBody3D:
		return

	dir = Vector3.ZERO
	dir.x = float(_d) - float(_a)
	dir.y = float(_e) - float(_q)
	dir.z = float(_s) - float(_w)

	if dir == Vector3.ZERO:
		parent.velocity = Vector3.ZERO
		parent.move_and_slide()
		return

	var m := dir.normalized()
	var f = parent.transform.basis * m
	var v = f * speed

	parent.velocity = v
	parent.move_and_slide()
