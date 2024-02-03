extends Button
@export var link_to:String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	#chanes to whatever scene the button is set to
	get_tree().change_scene_to_file(link_to)
