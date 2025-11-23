extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("drag_ended",_on_drag_ended)


func _on_drag_ended(ch:bool) -> void:
	if ch:
		$Label.text = str(value)
		%Ship/CollisionShape3D2.scale = Vector3.ONE * value
		%Ship/CollisionShape3D3.scale = Vector3.ONE * value
