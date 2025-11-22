extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("drag_ended",_on_drag_ended)


func _on_drag_ended(ch:bool) -> void:
	if ch:
		$Label.text = str(value)
		%Ship.scale = Vector3.ONE * value
