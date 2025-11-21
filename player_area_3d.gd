extends Area3D

#func _ready() -> void:
	#connect("area_exited",_area_exited)
	#connect("area_shape_exited",_area_shape_exited)
	#connect("body_exited",_body_exited)




func hurt() -> void:
	if $Timer.time_left > 0.1:
		return
	$Timer.start()
	%ProgressBar.value -= 1




#func _on_area_entered(area: Area3D) -> void:
	#hurt()


#func _on_area_shape_entered(area_rid: RID, area: Area3D, area_shape_index: int, local_shape_index: int) -> void:
	#hurt()
