extends Node
class_name HighScore

var cache : Dictionary = {"mini-jam-198-speed":[]}

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

signal done
const ENTRY_COUNT := 15

func load_all() -> void:
	if (!FileAccess.file_exists("highscore.json") or
		FileAccess.get_file_as_string("highscore.json").is_empty()):
		var json:FileAccess = FileAccess.open("highscore.json", FileAccess.WRITE)
		json.store_string(JSON.stringify(await dbload()))
	cache = JSON.parse_string(FileAccess.get_file_as_string("highscore.json"))

func dbload() -> Dictionary:
	FirebaseLite.initialize(firebaseConfig)
	var res:Dictionary = await FirebaseLite.RealtimeDatabase.read("")
	if typeof(res) != TYPE_DICTIONARY:
		return {}
	return res["mini-jam-198-speed"]

func save() -> void:
	FirebaseLite.initialize(firebaseConfig)
	var f := FileAccess.open("highscore.json", FileAccess.WRITE)
	if f == null:
		return

	var txt := JSON.stringify(cache)
	f.store_string(txt)

	await FirebaseLite.RealtimeDatabase.write("mini-jam-198-speed", cache)
	emit_signal("done")
