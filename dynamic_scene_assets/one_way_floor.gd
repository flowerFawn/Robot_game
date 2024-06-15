extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#old one way floor, now uses the one build into godot collision that I just missed when making this lmao
	#if abs(Player_Stats.player_current_forces.y) == Player_Stats.player_current_forces.y and not Player_Stats.player_is_climbing:
		#set_collision_layer_value(1, true)
	#else:
		#set_collision_layer_value(1, false)
	if Input.is_action_just_pressed("down"):
		set_collision_layer_value(12, false)
		set_collision_layer_value(4, false)
	if Input.is_action_just_released("down"):
		set_collision_layer_value(12, true)
		set_collision_layer_value(4, true)
