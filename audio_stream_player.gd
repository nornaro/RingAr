extends AudioStreamPlayer


func _input(event):
	if event is not InputEventKey:
		return
	if !event.pressed:
		return
	match event.keycode:
		KEY_KP_ADD:
			volume_db += 1
		KEY_KP_SUBTRACT:
			volume_db -= 1
		KEY_M:
			stream_paused = !stream_paused
