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
	Game.reset_data()
