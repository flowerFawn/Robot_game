extends Node2D
@export var is_left:bool
var projectile:Resource
var instanced_projectile
var damage:float
var projectile_speed:float
var projectile_turn_speed:float
var gain_damage:bool
var gain_speed:bool
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
	

func _process(_delta):
	is_shooting()
func decode_part_json():
	if is_left:
		var  stats: Dictionary = load("res://player_limbs/player_weapons/" + Selected_Limbs.parts["left_weapon"]).data
		return stats
	else:
		var stats: Dictionary = load("res://player_limbs/player_weapons/" + Selected_Limbs.parts["right_weapon"]).data
		return stats

func is_shooting():
	if ((is_left and Input.is_action_pressed("left_shoot")) or (not is_left and Input.is_action_pressed("right_shoot") and get_parent().get_parent().player_state != "sliding")) and get_node("Shot_cooldown").time_left == 0:
		shoot_projectile()
		
func shoot_projectile():
	#creates a new instance of the projectile, and sets its position
	if get_parent().get_parent().get_parent().has_node("Bullets"):
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
	
	



