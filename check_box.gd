extends CheckBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("toggled",_on_toggled)
	
func _on_toggled(t:bool) -> void:
	SB.greyscale = t
