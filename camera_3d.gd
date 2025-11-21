extends FreeLookCamera

var dir := Vector3.ZERO
var vel := Vector3.ZERO
var speed := 20


func _process(delta:float) -> void:
	_update_look()
	_update_move(delta)


func _update_look() -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		return

	var rel = _mouse_position * sensitivity
	_mouse_position = Vector2.ZERO

	var p := get_parent()
	if not p is CharacterBody3D:
		return

	var yaw = rel.x
	var pitch = rel.y

	var pitch_lim = clamp(
		pitch,
		-90.0 - _total_pitch,
		90.0 - _total_pitch
	)

	_total_pitch += pitch_lim

	p.rotate_y(deg_to_rad(-yaw))
	p.rotate_object_local(
		Vector3.RIGHT,
		deg_to_rad(-pitch_lim)
	)


func _update_move(delta:float) -> void:
	var p := get_parent()
	if not p is CharacterBody3D:
		return

	dir = Vector3.ZERO
	dir.x = float(_d) - float(_a)
	dir.y = float(_e) - float(_q)
	dir.z = float(_s) - float(_w)

	if dir == Vector3.ZERO:
		p.velocity = Vector3.ZERO
		p.move_and_slide()
		return

	var m := dir.normalized()
	var f = p.transform.basis * m
	var v = f * speed

	p.velocity = v
	p.move_and_slide()
