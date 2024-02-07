extends StaticBody2D
var limb_hp:float

func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	limb_hp = stats["hp"]
	if stats.has("script"):
		get_node("ScriptHost").set_script(load(stats["script"]))
		if get_node("ScriptHost").has_method("set_script_stats") and stats.has("script_value"):
			get_node("ScriptHost").set_script_stats(stats["script_value"])
	get_parent().add_stats(stats, self)

func decode_part_json():
	var stats: Dictionary = load("res://player_limbs/player_torsos/" + Selected_Limbs.parts["torso"]).data
	return stats
	
func start_slide(direction_multiplier):
	rotation_degrees = 90 * direction_multiplier
	
func end_slide(_direction_multiplier):
	rotation_degrees = 0
	
func _process(_delta):
	pass

func take_damage(damage):
	limb_hp -= damage / 2
	get_parent().current_hp -= damage
