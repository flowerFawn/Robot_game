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
	
func reset_data():
	var reset_location
	var default_data = JSON.stringify(load("res://saves/defaults/defaults_owned.json").data, "\n\t")
	var limb_types = ["arms", "legs", "torsos", "weapons"]
	for limb_type in limb_types:
		reset_location = FileAccess.open("res://saves/owned_" + limb_type + ".json", FileAccess.WRITE)
		reset_location.store_string(default_data)
	var default_files = DirAccess.open("res://saves/defaults")
	for file in default_files.get_files():
		if file != "defaults_owned.json":
			default_data = load("res://saves/defaults/" + file).data
			reset_location = FileAccess.open("res://saves/" + file, FileAccess.WRITE)
			reset_location.store_string(JSON.stringify(default_data, "\n\t"))
			
		
