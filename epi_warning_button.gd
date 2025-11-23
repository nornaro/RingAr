extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("pressed",_on_pressed)
	
func _on_pressed() -> void:
	%EpiWarningText.visible = !%EpiWarningText.visible
