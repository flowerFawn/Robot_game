extends CharacterBody2D

var enabled:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if enabled:
		get_node("LeftArm").look_at(Player_Stats.player_position)
		get_node("LineOfSight").target_position = Vector2(Player_Stats.player_position.x - global_position.x, Player_Stats.player_position.y - global_position.y)


func _on_enable_radius_body_entered(body):
	print("enter not made the if")
	print(body)
	if body.is_in_group("player"):
		print("test")
		enabled = true
	



func _on_enable_radius_body_exited(body):
	print("not made the if")
	if body.is_in_group("player"):
		print("test exit")
		enabled = false
