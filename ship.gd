extends CharacterBody3D

func _physics_process(_delta: float) -> void:
	%ProgressBar.value -= get_slide_collision_count()
	if %ProgressBar.value <= 0:
		%GOver.show()
		get_tree().paused = true
