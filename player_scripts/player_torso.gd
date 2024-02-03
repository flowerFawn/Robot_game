extends StaticBody2D
var limb_hp:float

func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	limb_hp = stats["hp"]
	get_parent().add_stats(stats)

func decode_part_json():
	var stats: Dictionary = load("res://player_limbs/player_torsos/" + Selected_Limbs.parts["torso"]).data
	return stats
	
func start_slide(direction_multiplier):
	rotation_degrees = 90 * direction_multiplier
	
func end_slide(_direction_multiplier):
	rotation_degrees = 0
	
func _process(delta):
	pass
