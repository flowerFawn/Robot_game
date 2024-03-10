extends StaticBody2D
var limb_hp:float
var total_limb_hp:float
var stats: Dictionary
var limb_id:String = "torso"
func _ready():
	stats = decode_part_json()
	total_limb_hp = stats["hp"]
	limb_hp = total_limb_hp
	if stats.has("script"):
		get_node("ScriptHost").set_script(load(stats["script"]))
		if get_node("ScriptHost").has_method("set_script_stats") and stats.has("script_value"):
			get_node("ScriptHost").set_script_stats(stats["script_value"])
	if stats.has("texture") and load(stats["texture"]) != null:
		get_node("TorsoSprite").texture = load(stats["texture"])
	else:
		print("set texture, or set it to a real texture")
	get_parent().add_stats(stats, self)

func decode_part_json():
	var reading_stats: Dictionary = load("res://player_limbs/player_torsos/" + Selected_Limbs.parts["torso"]).data
	return reading_stats
	
func start_slide(direction_multiplier):
	rotation_degrees = 90 * direction_multiplier
	get_node("TorsoSprite").flip_v = true
	
func end_slide(_direction_multiplier):
	rotation_degrees = 0
	get_node("TorsoSprite").flip_v = false
	
func _process(_delta):
	pass

func take_damage(damage):
	print(limb_hp)
	limb_hp -= damage / 2
	print(limb_hp)
	get_parent().current_hp -= damage
	#if it has run out of hp it tells the main script then removes itself
	if limb_hp < 0:
		queue_free()
		get_parent().die()
