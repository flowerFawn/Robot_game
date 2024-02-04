extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	get_node("LeftArm").look_at(Player_Stats.player_position)
	get_node("LineOfSight").target_position = Vector2(Player_Stats.player_position.x - global_position.x, Player_Stats.player_position.y - global_position.y)
