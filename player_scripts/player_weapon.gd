extends Node2D
@export var is_left:bool
var projectile:Resource
var instanced_projectile
var damage:float
var projectile_speed:float
var projectile_turn_speed:float
var gain_damage:bool
var gain_speed:bool
var spin_up:float
var left_spinning:bool
var right_spinning:bool
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	#sets the scene that will be instanced as the projecitile
	projectile = load(stats["projectile"])
	damage = stats["damage"]
	if stats.get("projectile_turn_speed") != null:
		projectile_turn_speed = stats["projectile_turn_speed"]
	get_node("Shot_cooldown").wait_time = stats["attack_speed"]
	gain_damage = stats.get("gain_damage", false)
	projectile_speed = stats["projectile_speed"]
	gain_speed = stats.get("gain_speed", false)
	get_parent().get_parent().add_stats(stats, self)
	spin_up = stats.get("spin_up", 0)
	right_spinning = true
	left_spinning = true
	await get_tree().create_timer(spin_up).timeout
	right_spinning = false
	left_spinning = true
	

func _process(_delta):
	is_shooting()
func decode_part_json():
	if is_left:
		var  stats: Dictionary = load("res://player_limbs/player_weapons/" + Selected_Limbs.parts["left_weapon"] + ".json").data
		return stats
	else:
		var stats: Dictionary = load("res://player_limbs/player_weapons/" + Selected_Limbs.parts["right_weapon"] + ".json").data
		return stats

func will_shoot():
	if (is_left and Input.is_action_pressed("left_shoot")) or (not is_left and Input.is_action_pressed("right_shoot")):
		if (get_parent().get_parent().player_state != "sliding" or is_left) and get_node("Shot_cooldown").time_left == 0:
			if (is_left and not left_spinning) or (not is_left and not right_spinning):
				return true
			else:
				return false
		else:
			return false
	else:
		return false

func is_shooting():
	if Input.is_action_just_pressed("left_shoot") and is_left:
		left_spinning = true
		await get_tree().create_timer(spin_up).timeout
		left_spinning = false
		
	if Input.is_action_just_pressed("right_shoot") and not is_left:
		right_spinning = true
		await get_tree().create_timer(spin_up).timeout
		right_spinning = false
		
	if will_shoot():
		shoot_projectile()
		
func shoot_projectile():
	#creates a new instance of the projectile, and sets its position
	get_node("Shot_cooldown").start()
	instanced_projectile = projectile.instantiate()
	instanced_projectile.global_position = global_position
	instanced_projectile.set_collision_mask_value(2, false)
	instanced_projectile.targeted_group = "enemy"
	instanced_projectile.rotation_degrees = get_parent().rotation_degrees
	instanced_projectile.damage = damage
	instanced_projectile.speed = projectile_speed
	instanced_projectile.gain_damage = gain_damage
	instanced_projectile.gain_speed = gain_speed
	if "turn_rate" in instanced_projectile:
		instanced_projectile.turn_rate = projectile_turn_speed
	get_parent().get_parent().get_parent().get_node("Bullets").add_child(instanced_projectile)
	
	



