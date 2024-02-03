extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	get_parent().add_stats(stats)

func decode_part_json():
	var stats: Dictionary = load("res://player_limbs/player_torsos/" + Selected_Limbs.parts["torso"]).data
	return stats
	
func start_slide(direction_multiplier):
	rotation_degrees = 90 * direction_multiplier
# Called every frame. 'delta' is the elapsed time since the previous frame.
func end_slide(_direction_multiplier):
	rotation_degrees = 0
	
func _process(delta):
	pass
