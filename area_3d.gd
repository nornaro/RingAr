extends Area3D

const SHIFT_MULTIPLIER = 25

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_exited",_on_exited)


func _on_exited(_area) -> void:
	SB.temp_score += 1
	get_parent().remove_from_group("ring")
	await get_tree().create_timer(5).timeout
	get_parent().queue_free()
