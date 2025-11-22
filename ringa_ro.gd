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
@export var sed:int = 11
var highscore = HighScore.new()

func _ready() -> void:
	var res = FirebaseLite.initialize(highscore.firebaseConfig)
	if res != 0:
		push_error("DB connection failed!")
	highscore.load_all()
	print(highscore.cache)

func _gen() -> void:
	if sed:
		rnd.seed = sed
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	%Rings.add_child(ring_scene.duplicate())
	while get_tree().get_node_count_in_group("ring") < ring_count_max:
		gen_ring()

func gen_ring() -> void:
	### create base path to start with
	if rnd.randi_range(0,1) == 0:
		rota = Vector3.ZERO
	if rnd.randi_range(0,10) > 0:
		rota.y += rnd.randi_range(-10,10)/100.0
	if randi_range(0,10) > 0:
		rota.z += rnd.randi_range(-10,10)/100.0
		
	var scene = ring_scene.duplicate()
	
	last_ring.add_child(scene)
	scene.position = Vector3(2,0,0)
	scene.rotation = rota
	scene.reparent(%Rings)
	scene.add_to_group("ring")
	last_ring = scene
	
var c:float
func _physics_process(delta: float) -> void:
	if c >= 60:
		c = 0
		SB.score += SB.temp_score - 500
		%Score.text = str(SB.score)
		SB.temp_score = 0
	c += delta
	while get_tree().get_node_count_in_group("ring") < ring_count_max:
		gen_ring()

	
