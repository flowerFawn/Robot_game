extends Node

var game_info = {"scrap" : 0,}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func save_game():
	#this saves things like scrap, not owned limbs, those are saved right as they are bought, though this is also ran to avoid getting them without spending scrap
	var save_location = FileAccess.open("res://saves/game_info.json", FileAccess.WRITE)
	save_location.store_string(JSON.stringify(game_info, "\n\t"))
	
