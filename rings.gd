extends Node3D

@onready var ring_scene:PackedScene = preload("res://ring_R.tscn")
var rnd:RandomNumberGenerator = RandomNumberGenerator.new()
#var last_pos = Vector3.ZERO
@onready var last_ring:Node = %Rings
var direction:Vector3 = Vector3.ZERO
var rota:Vector3 = Vector3.ZERO
var pos:Vector3 = Vector3.ZERO
var start:Vector3 = Vector3.ZERO
var ring_counter:int = 0
var ring_count_max:int = 200
var ring_reg:Dictionary = {}


func _ready() -> void:
	#SB.highscore.load_all()
	#SB.highscore.dbload()
	if %CustomSeed.text != "":
		rnd.seed = int(%CustomSeed.text)
	SB.wseed = rnd.seed
	SB.sseed = str(rnd.seed)
	%Seed.text = str(rnd.seed)
	%CustomSeed.text = str(rnd.seed)
	get_tree().call_group("LoadSeed","update")
	
	%Start.visible = true

func _gen() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	add_child(ring_scene.instantiate())
	while get_tree().get_node_count_in_group("ring") < ring_count_max:
		gen_ring()

func gen_ring() -> void:
	if rnd.randi_range(0,1) == 0:
		rota = Vector3.ZERO
	if rnd.randi_range(0,10) > 0:
		rota.y += rnd.randi_range(-10,10)/150.0
	if rnd.randi_range(0,10) > 0:
		rota.z += rnd.randi_range(-10,10)/150.0
		
		
	var scene:StaticBody3D = ring_scene.instantiate()
	
	last_ring.add_child(scene)
	scene.position = Vector3(2.5,0,0) + pos
	scene.rotation = rota
	scene.reparent(self)
	scene.add_to_group("ring")
	last_ring = scene
	ring_reg[ring_counter] = last_ring.global_transform
	ring_counter += 1
	
var c:float
func _physics_process(delta: float) -> void:
	if SB.ring_count < 1:
		return
	if c >= 6:
		c = 0
		SB.score += SB.temp_score - 50
		%Score.text = str(SB.score)
		SB.temp_score = 0
	c += delta

	while get_tree().get_node_count_in_group("ring") < ring_count_max:
		gen_ring()
	
