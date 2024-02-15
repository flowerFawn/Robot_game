extends StaticBody2D
@export var is_left:bool
var limb_hp:float
var total_limb_hp:float
var stats:Dictionary
#stores things like right_leg, so it can be removed when destroyed
var limb_id:String
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_left:
		limb_id = "left_leg"
	else:
		limb_id = "right_leg"
	stats = decode_part_json()
	total_limb_hp = stats["hp"]
	limb_hp = total_limb_hp
	if stats.has("script"):
		get_node("ScriptHost").set_script(load(stats["script"]))
		if get_node("ScriptHost").has_method("set_script_stats") and stats.has("script_value"):
			get_node("ScriptHost").set_script_stats(stats["script_value"])
	get_parent().add_stats(stats, self)

func decode_part_json():
	#uses selected limbs to get the selected limb and then the json for it
	if is_left:
		var reading_stats: Dictionary = load("res://player_limbs/player_legs/" + Selected_Limbs.parts["left_leg"]).data
		return reading_stats
	else:
		var reading_stats: Dictionary = load("res://player_limbs/player_legs/" + Selected_Limbs.parts["right_leg"]).data
		return reading_stats
# Called every frame. 'delta' is the elapsed time since the previous frame.

func start_slide(direction_multiplier):
	position.x += 15 * direction_multiplier
	if is_left:
		position.y -= 5
		rotation_degrees = 100 * direction_multiplier
		if direction_multiplier == -1:
			position.x -= 3
	else:
		position.y -= 4
		rotation_degrees = 90 * direction_multiplier
	
func end_slide(direction_multiplier):
	position.x -= 15 * direction_multiplier
	if is_left:
		position.y += 5
		rotation_degrees = 0
		if direction_multiplier == -1:
			position.x += 3
	else:
		position.y += 4
		rotation_degrees = 0


func take_damage(damage):
	limb_hp -= damage / 2
	get_parent().current_hp -= damage
	#removes the leg from the scene and tells the main player it has lost a leg
	if limb_hp < 0:
		queue_free()
		get_parent().remove_stats(stats, self)
