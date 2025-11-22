extends Node
class_name HighScore

var db := RealtimeDatabase.new()
var cache : Dictionary = {}	# { seed : { "seed":seed, "top":[] } }

var firebaseConfig : Dictionary = {
  "apiKey": "AIzaSyC75KCQ2aLxvAAgZbCcmrcU6Yq_F4kXzXw",
  "authDomain": "stevepinejam.firebaseapp.com",
  "databaseURL": "https://stevepinejam-default-rtdb.europe-west1.firebasedatabase.app",
  "projectId": "stevepinejam",
  "storageBucket": "stevepinejam.firebasestorage.app",
  "messagingSenderId": "781842316940",
  "appId": "1:781842316940:web:bd2b467064ebaf27b585a9",
  "measurementId": "G-QP2QWNPCXR"
};

const ENTRY_COUNT := 15

func load_all() -> void:
	if !FileAccess.file_exists("highscore.json"):
		var res = await FirebaseLite.RealtimeDatabase.read("")
		if typeof(res) != TYPE_DICTIONARY:
			return
		var json = FileAccess.open("highscore.json", FileAccess.WRITE)
		json.store_string(JSON.stringify(res))
	cache = JSON.parse_string(FileAccess.get_file_as_string("highscore.json"))


func get_seed_entry(seed : String) -> Dictionary:
	if not cache.has(seed):
		return {}

	return cache[seed]


func create_seed(seed : String, score : int) -> Dictionary:
	var entry := {
		"seed": seed,
		"top": [score]
	}

	cache[seed] = entry
	return entry


func is_highscore(entry : Dictionary, score : int) -> bool:
	var top : Array = entry["top"]
	if top.size() < ENTRY_COUNT:
		return true

	return score > top[-1]


func insert_score(entry : Dictionary, score : int):
	var top : Array = entry["top"]
	top.append(score)
	top.sort()
	top.reverse()

	if top.size() > ENTRY_COUNT:
		top.resize(ENTRY_COUNT)


func upload_seed(seed : String):
	var entry = cache[seed]
	await db.write(seed, entry)


func submit_score(seed : String, score : int):
	var entry = get_seed_entry(seed)
	if entry.is_empty():
		entry = create_seed(seed, score)
		await upload_seed(seed)
		return

	if not is_highscore(entry, score):
		return

	var fresh = await db.read(seed)
	if typeof(fresh) == TYPE_DICTIONARY:
		cache[seed] = fresh
		entry = fresh

	if not is_highscore(entry, score):
		return

	insert_score(entry, score)
	await upload_seed(seed)
