extends CharacterBody3D

func _physics_process(_delta: float) -> void:
	%ProgressBar.value -= get_slide_collision_count()
	if %ProgressBar.value <= 0:
		%GOver.show()
		SB.update_highscore()
		set_physics_process(false)
		await SB.highscore.done
		#get_tree().paused = true
