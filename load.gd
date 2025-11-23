extends ItemList


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("item_selected",_on_item_selected)
	update()
	
func update() -> void:
	clear()
	for item:String in SB.highscore.cache.keys():
		add_item(item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_item_selected(item: int) -> void:
	%CustomSeed.text = get_item_text(item)
	%HighScore.clear()
	%Seed.text = %CustomSeed.text
	for i:int in SB.highscore.cache[%CustomSeed.text]:
		%HighScore.add_item(str(i))
	
