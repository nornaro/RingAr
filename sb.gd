extends Node

var gate_counter:int = 0
var temp_score:int = 0
var score:int = 0
var greyscale:bool = false
var ring_count:int = 0
var wseed:int
var sseed:String
var highscore:HighScore = HighScore.new()

func _ready() -> void:
	var res:int = FirebaseLite.initialize(highscore.firebaseConfig)
	if res != 0:
		push_error("DB connection failed!")
	#highscore.dbload()


func check_highscore() -> bool:
	highscore.cache.sort()
	if (highscore.cache.has(sseed) and
		!highscore.cache[sseed].size() < 15 and 
		highscore.cache[sseed][0] > score
	):
		return false
	highscore.cache = await highscore.dbload()
	get_tree().call_group("LoadSeed","update")
	highscore.cache.sort()
	if (highscore.cache.has(sseed) and
		highscore.cache[sseed].size() == 15 and 
		highscore.cache[sseed][0] > score
	):
		return false
	
	if !highscore.cache.has(sseed):
		highscore.cache[str(sseed)] = [score]
		return true
	if highscore.cache[sseed].size() < 15:
		highscore.cache[sseed].append(score)
		return true
	if highscore.cache[sseed][0] < score:
		highscore.cache[sseed].pop_at(0)
		highscore.cache[sseed].append(score)
		return true
	return false

func update_highscore() -> void:
	if (await check_highscore()):
		highscore.save()
		return
	await SB.highscore.done
