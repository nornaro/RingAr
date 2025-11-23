extends Node

var gate_counter:int = 0
var temp_score:int = 0
var score:int = 0
var greyscale:bool = false
var wseed:int
var highscore:HighScore = HighScore.new()

func _ready() -> void:
	var res:int = FirebaseLite.initialize(highscore.firebaseConfig)
	if res != 0:
		push_error("DB connection failed!")
	highscore.load_all()


func check_highscore() -> bool:
	##refact correct check
	
	if !highscore.cache.has(wseed):
		highscore.dbload()
	if !highscore.cache.has(wseed):
		highscore.cache[wseed] = [score]
		return true
		
	if highscore.cache[wseed].size() < 15:
		highscore.cache[wseed].append(score)
		return true
		
	highscore.cache[wseed].sort()
	var lowest:int = highscore.cache[wseed][0]
	if score > lowest:
		highscore.cache[wseed].pop_at(0)
		highscore.dbload()
		highscore.cache[wseed].append(score)
		return true

	return false

func update_highscore() -> void:
	if check_highscore():
		
		highscore.save()
		return
	
	highscore.emit_signal("done")
