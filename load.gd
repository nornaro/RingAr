extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("item_selected",_on_item_selected)
	
func update() -> void:
	clear()
	for item:String in (await SB.highscore.dbload()).keys():
		add_item(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_item_selected(item: int) -> void:
	%CustomSeed.text = get_item_text(item)
	%Rings.rnd.seed = int(get_item_text(item))
	%HighScore.clear()
	%Seed.text = %CustomSeed.text
	for i in SB.highscore.cache[%CustomSeed.text]:
		%HighScore.add_item(str(int(SB.highscore.cache[%CustomSeed.text][i])))
	
