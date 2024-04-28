extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func quit():
	Game.save_game()
	get_tree().quit()

func reset_data():
	var default_data = JSON.stringify(load("res://saves/defaults/defaults_owned.json").data, "\n\t")
	var limb_types = ["arms", "legs", "torsos", "weapons"]
	for limb_type in limb_types:
		var owned_file = FileAccess.open("res://saves/owned_" + limb_type + ".json", FileAccess.WRITE)
		owned_file.store_string(default_data)
