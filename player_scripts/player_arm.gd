extends StaticBody2D
@export var is_left: bool
const UNSHOOTABLE_STATES = ["disabled", "sliding", "climbing"]
var speed_multiplier: int
var limb_hp:float
var limb_id:String
var stats

func _ready():
	if is_left:
		limb_id = "left_arm"
	else:
		limb_id = "right_arm"
	stats = decode_part_json()
	limb_hp = stats["hp"]
	if stats.has("script"):
		get_node("ScriptHost").set_script(load(stats["script"]))
		if get_node("ScriptHost").has_method("set_script_stats") and stats.has("script_value"):
			get_node("ScriptHost").set_script_stats(stats["script_value"])
	get_parent().add_stats(stats, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (get_parent().player_state not in UNSHOOTABLE_STATES and not get_parent().is_climbing) or is_left:
		look_at(get_global_mouse_position())
		if rotation_degrees != abs(rotation_degrees):
			rotation_degrees += 360
		if rotation_degrees > 360:
			rotation_degrees = fmod(rotation_degrees, 360)
	print(get_node("ArmSprite").flip_v)
	if 270 > rotation_degrees and rotation_degrees > 90:
		get_node("ArmSprite").flip_v = true
	else:
		get_node("ArmSprite").flip_v = false
		

func decode_part_json():
	#gets the data for the selected limb of this type
	if is_left:
		var reading_stats: Dictionary = load("res://player_limbs/player_arms/" + Selected_Limbs.parts["left_arm"]).data
		return reading_stats
	else:
		var reading_stats: Dictionary = load("res://player_limbs/player_arms/" + Selected_Limbs.parts["right_arm"]).data
		return reading_stats

func start_slide(direction_multiplier):
	if not is_left:
		rotation_degrees = 150 
		position.y += 4
		position.x -= 4 * direction_multiplier
		if direction_multiplier == -1:
			position.x += 6
			rotation_degrees -= 110
	else:
		position.x -= 4
		
func end_slide(direction_multiplier):
	if not is_left:
		rotation_degrees = 0
		position.y -= 4
		position.x += 4 * direction_multiplier
		if direction_multiplier == -1:
			position.x -= 6
			rotation_degrees += 110
	else:
		position.x += 4
		
func take_damage(damage):
	limb_hp -= damage / 2
	get_parent().current_hp -= damage
	if limb_hp < 0:
		queue_free()
		get_parent().remove_stats(stats, self)
