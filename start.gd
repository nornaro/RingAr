extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed",_on_pressed)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED


	
func _on_pressed() -> void:
	%Title.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
