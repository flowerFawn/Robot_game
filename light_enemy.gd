extends CharacterBody2D
var within_shooting_range:bool = false
var enabled:bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _physics_process(_delta):
	if enabled:
		#looks at players position and aims raycast for line of sight
		get_node("LeftArm").look_at(Player_Stats.player_position)
		get_node("LineOfSight").target_position = Vector2(Player_Stats.player_position.x - global_position.x, Player_Stats.player_position.y - global_position.y)
		#starts the timer to shoot
		if within_shooting_range:
			get_node("LeftArm/WeaponSystem/WeaponCharge").start()
		#stops, NOT PAUSES the timer.
		else:
			get_node("LeftArm/WeaponSystem/WeaponCharge").stop()

func _on_enable_radius_body_entered(body):
	#if player exits the activation range
	if body.is_in_group("player"):
		enabled = true
		
	


func _on_enable_radius_body_exited(body):
	#if player exits the activation range
	if body.is_in_group("player"):
		enabled = false


func _on_shoot_radius_body_entered(body):
	if body.is_in_group("player"):
		within_shooting_range = true

func _on_shoot_radius_body_exited(body):
	if body.is_in_group("player"):
		within_shooting_range = false


func _on_weapon_charge_timeout():
	pass # bullet shooty
