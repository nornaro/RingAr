extends MeshInstance3D

var clr:Color = Color.WHITE
var mat := StandardMaterial3D.new()

# set this from outside
var grayscale:bool = false

func _ready() -> void:
	set_surface_override_material(0, mat)


func _physics_process(_delta: float) -> void:
	if SB.greyscale:
		clr.r += randf_range(-1, 1)/100
		clr.g = clr.r
		clr.b = clr.r

		mat.albedo_color = clr
		return
		
	if randi_range(0,1) == 0:
		if randi_range(0, 10) > 0:
			clr.r = clr.r + randi_range(-1, 1) / 100.0

		if randi_range(0, 10) > 0:
			clr.g = clr.g + randi_range(-1, 1) / 100.0

		if randi_range(0, 10) > 0:
			clr.b = clr.b + randi_range(-1, 1) / 100.0
		mat.albedo_color = clr
		return
	
	if randi_range(0,1) == 1:
		clr.r = clamp(clr.r + randi_range(-1, 1) / 100.0, 0.0, 1.0)

		if randi_range(0, 10) > 0:
			clr.g = clamp(clr.g + randi_range(-1, 1) / 100.0, 0.0, 1.0)

		if randi_range(0, 10) > 0:
			clr.b = clamp(clr.b + randi_range(-1, 1) / 100.0, 0.0, 1.0)

		mat.albedo_color = clr
