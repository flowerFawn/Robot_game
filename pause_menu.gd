extends CanvasLayer

signal switched_pause

func _ready():
	switched_pause.connect(get_parent().get_node("UIControl").switch_pause)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		switch_pause()
		
func switch_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused
	switched_pause.emit()
