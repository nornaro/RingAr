extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed",_on_pressed)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


	
func _on_pressed() -> void:
	%Title.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().paused = false
	$"../../..".set_physics_process(true)
	
	SB.wseed = int(%CustomSeed.text)
	SB.sseed = %CustomSeed.text
	%Rings._gen()
	%Rings.set_physics_process(true)

func _input(event:InputEvent) -> void:
	if event is not InputEventKey:
		return
	if !event.pressed:
		return
	match event.keycode:
		KEY_ESCAPE:
			%Title.visible = !%Title.visible
			#$"../../..".set_physics_process(%Title.visible)
			if %Title.visible:
				Input.mouse_mode = Input.MOUSE_MODE_CONFINED
			if !%Title.visible:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
