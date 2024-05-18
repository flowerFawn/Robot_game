extends CharacterBody2D
var within_shooting_range:bool = false
var enabled:bool = false
var current_forces:Vector2
@export var hp:float = 50
@export var damage:float = 10
@export var bullet_speed:float = 30
var preloaded_bullet = preload("res://instanceables/projectiles/base_bullet.tscn")
var rng = RandomNumberGenerator.new()
var preloaded_scrap = preload("res://instanceables/scrap/scrap_chunk.tscn")
var point_blank:bool = false

func _ready():
	pass

func add_gravity(delta):
	#uses the floor ray like is_on_floor()
	if get_node("FloorRay").get_collider() == null or not get_node("FloorRay").get_collider().is_in_group("floor"):
		current_forces.y += 100 * delta
	else:
		current_forces.y = 0

func _process(_delta):
	pass
	
func attempt_shot():
	#starts the timer to shoot if within shooting range and timer is inactive (time_left returns 0 when inactive)
	if can_shoot():
		get_node("LeftArm/WeaponSystem/WeaponCharge").start()
	#stops, NOT PAUSES the timer.
	elif not within_shooting_range or point_blank:
		get_node("LeftArm/WeaponSystem/WeaponCharge").stop()
		
func can_shoot():
	if within_shooting_range and get_node("LeftArm/WeaponSystem/WeaponCharge").time_left == 0 and  not get_node("LineOfSight").is_colliding():
		if point_blank == false:
			return true
		else:
			return false
	else:
		return false
		
func movement_checks():
	if abs(Player_Stats.player_position.x - global_position.x) > 140 and not get_node("LineOfSight").is_colliding():
		if Player_Stats.player_position.x < global_position.x and get_node("leftedgecheck").is_colliding():
			current_forces.x = -40
		elif get_node("rightedgecheck").is_colliding():
			current_forces.x = 40
	elif abs(Player_Stats.player_position.x - global_position.x) < 70 and not get_node("LineOfSight").is_colliding():
		if Player_Stats.player_position.x < global_position.x and get_node("rightedgecheck").is_colliding():
			current_forces.x = 40
		elif get_node("leftedgecheck").is_colliding():
			current_forces.x = -40

func move_line_of_sight():
	get_node("LeftArm").look_at(Player_Stats.player_position)
	get_node("LineOfSight").target_position = Vector2(Player_Stats.player_position.x - global_position.x, Player_Stats.player_position.y - global_position.y)
	
func _physics_process(delta):
	if enabled:
		current_forces.x = 0
		add_gravity(delta)
		movement_checks()
		#looks at players position and aims raycast for line of sight
		move_line_of_sight()
		attempt_shot()
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
		die()
		
func die():
	#creates 0-3 scrap chunks that the player can collect
	var scrap_chunks:int = rng.randi_range(0, 3)
	var new_scrap_chunk:Node2D
	if scrap_chunks != 0:
		for scrap_chunk in range(1, scrap_chunks):
			new_scrap_chunk = preloaded_scrap.instantiate()
			new_scrap_chunk.global_position = global_position
			new_scrap_chunk.global_rotation_degrees = rng.randi_range(0, 360)
			#sets up each and adds them to the world
			get_parent().get_node("Scrap").add_child(new_scrap_chunk)
	queue_free()




func _on_point_blank_radius_body_entered(body):
	if body.is_in_group("player"):
		point_blank = true


func _on_point_blank_radius_body_exited(body):
	if body.is_in_group("player"):
		point_blank = false
