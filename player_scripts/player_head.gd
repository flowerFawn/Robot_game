extends StaticBody2D
var limb_hp:float
var limb_id = "head"
var stats

# Called when the node enters the scene tree for the first time.
func _ready():
	stats = decode_part_json()
	limb_hp = stats["hp"]
	if stats.has("script"):
		get_node("ScriptHost").set_script(load(stats["script"]))
		if get_node("ScriptHost").has_method("set_script_stats") and stats.has("script_value"):
			get_node("ScriptHost").set_script_stats(stats["script_value"])
	#if stats.has("texture") and FileAccess.file_exists(stats["texture"]):
		#get_node("HeadSprite").texture = load(stats["texture"])
	#else:
		#print("set texture, or set it to a real texture")
	get_parent().add_stats(stats, self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func decode_part_json():
	#gets the data for the selected limb of this type
	var reading_stats: Dictionary = load("res://player_limbs/player_heads/" + Selected_Limbs.parts["head"] + ".json").data
	return reading_stats

func start_slide(direction_multiplier):
	rotation_degrees = 90
	position.y += 9
	position.x -= 4 * direction_multiplier
	if direction_multiplier == -1:
		position.x += 2
	else:
		position.x -= 19

		
func end_slide(direction_multiplier):
	rotation_degrees = 0
	position.y -= 9
	position.x += 4 * direction_multiplier
	if direction_multiplier == -1:
		position.x -= 2
	else:
		position.x += 19
		
func take_damage(damage):
	limb_hp -= damage / 2
	get_parent().current_hp -= damage
	if limb_hp < 0:
		queue_free()
		get_parent().die()
