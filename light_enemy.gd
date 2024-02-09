extends CharacterBody2D
var within_shooting_range:bool = false
var enabled:bool = false
var current_forces:Vector2
@export var hp:float = 50
@export var damage:float = 10
@export var bullet_speed:float = 30
var preloaded_bullet = preload("res://instanceables/projectiles/base_bullet.tscn")

func _ready():
	pass



func _process(_delta):
	pass

func _physics_process(delta):
	if enabled:
		current_forces.x = 0
		if abs(Player_Stats.player_position.x - global_position.x) > 140 and not get_node("LineOfSight").is_colliding():

			if Player_Stats.player_position.x < global_position.x and get_node("leftedgecheck").is_colliding():
				current_forces.x = -40
			elif get_node("rightedgecheck").is_colliding():
				current_forces.x = 40
		elif abs(Player_Stats.player_position.x - global_position.x) < 70 and not get_node("LineOfSight").is_colliding():

			if Player_Stats.player_position.x < global_position.x and get_node("leftedgecheck").is_colliding():
				current_forces.x = 40
			elif get_node("rightedgecheck").is_colliding():
				current_forces.x = -40
		#looks at players position and aims raycast for line of sight
		get_node("LeftArm").look_at(Player_Stats.player_position)
		get_node("LineOfSight").target_position = Vector2(Player_Stats.player_position.x - global_position.x, Player_Stats.player_position.y - global_position.y)
		#starts the timer to shoot if within shooting range and timer is inactive (time_left returns 0 when inactive
		if within_shooting_range and get_node("LeftArm/WeaponSystem/WeaponCharge").time_left == 0 and  not get_node("LineOfSight").is_colliding():
			get_node("LeftArm/WeaponSystem/WeaponCharge").start()
		#stops, NOT PAUSES the timer.
		elif not within_shooting_range:
			get_node("LeftArm/WeaponSystem/WeaponCharge").stop()
		move_and_collide(current_forces * delta)

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
	instancing_bullet.set_collision_mask_value(9, false)
	#gets the node of the scene 
	#ENEMY MUST BE A DIRECT CHILD OF THE NODE2D OF THE LEVEL OR ANOTHER UNMOVING NODE
	get_parent().get_node("Bullets").add_child(instancing_bullet)

func take_damage(damage_dealt_to):
	hp -= damage_dealt_to
	if hp < 0:
		queue_free()
