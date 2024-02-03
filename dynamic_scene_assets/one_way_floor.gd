extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if abs(Player_Stats.player_current_forces.y) == Player_Stats.player_current_forces.y:
		set_collision_layer_value(1, true)
	else:
		set_collision_layer_value(1, false)
