extends MeshInstance3D

var clr = Color.WHITE

func _physics_process(delta: float) -> void:
	if randi_range(0,10) > 0:
		clr.r += randi_range(-1,1)/100.0
	if randi_range(0,10) > 0:
		clr.g += randi_range(-1,1)/100.0
	if randi_range(0,10) > 0:
		clr.b += randi_range(-1,1)/100.0
	var mat = StandardMaterial3D.new()
	mat.albedo_color = clr
	set_surface_override_material(0,mat)
