extends Node3D

@onready var ring_scene = preload("res://ring_R.tscn").instantiate()
var rnd = RandomNumberGenerator.new()
#var last_pos = Vector3.ZERO
@onready var last_ring = %Rings
var direction = Vector3.ZERO
var rota = Vector3.ZERO
var start = Vector3.ZERO
var ring_count = 0
var ring_count_max = 200

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	%Rings.add_child(ring_scene.duplicate())
	while get_tree().get_node_count_in_group("ring") < ring_count_max:
		gen_ring()

func gen_ring() -> void:
	### create base path to start with
	if randi_range(0,1) == 0:
		rota = Vector3.ZERO
	if randi_range(0,10) > 0:
		rota.y += randi_range(-10,10)/100.0
	if randi_range(0,10) > 0:
		rota.z += randi_range(-10,10)/100.0
		
	var scene = ring_scene.duplicate()
	
	last_ring.add_child(scene)
	scene.position = Vector3(2.5,0,0)
	scene.rotation = rota
	scene.reparent(%Rings)
	scene.add_to_group("ring")
	last_ring = scene
	
	
func _process(delta: float) -> void:
	while get_tree().get_node_count_in_group("ring") < ring_count_max:
		gen_ring()
