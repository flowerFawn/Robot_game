extends CharacterBody2D
var within_shooting_range:bool = false
var enabled:bool = false
@export var hp:float = 50
@export var damage:float = 10
@export var bullet_speed:float = 30
var preloaded_bullet = preload("res://instanceables/base_bullet.tscn")
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
		#starts the timer to shoot if within shooting range and timer is inactive (time_left returns 0 when inactive
		if within_shooting_range and get_node("LeftArm/WeaponSystem/WeaponCharge").time_left == 0:
			get_node("LeftArm/WeaponSystem/WeaponCharge").start()
		#stops, NOT PAUSES the timer.
		elif not within_shooting_range:
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
	var instancing_bullet:Node = preloaded_bullet.instantiate()
	instancing_bullet.global_position = get_node("LeftArm/WeaponSystem").global_position
	instancing_bullet.rotation = get_node("LeftArm").rotation
	instancing_bullet.targeted_group = "player"
	instancing_bullet.speed = bullet_speed
	instancing_bullet.damage = damage
	#gets the node of the scene 
	#ENEMY MUST BE A DIRECT CHILD OF THE NODE2D OF THE LEVEL OR ANOTHER UNMOVING NODE
	get_parent().add_child(instancing_bullet)
