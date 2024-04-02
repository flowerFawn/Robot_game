extends CanvasLayer

signal switched_pause

func _ready():
	visible = false
	switched_pause.connect(get_parent().get_node("UIControl").switch_pause)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		switch_pause()
		
func switch_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
	switched_pause.emit()


func reset_data():
	var default_data = JSON.stringify(load("res://saves/defaults/defaults_owned.json").data, "\n\t")
	var limb_types = ["arms", "legs", "torsos", "weapons"]
	for limb_type in limb_types:
		var owned_file = FileAccess.open("res://saves/owned_" + limb_type + ".json", FileAccess.WRITE)
		owned_file.store_string(default_data)
		
