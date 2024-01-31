extends StaticBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	get_parent().add_stats(stats)

func decode_part_json():
	var stats: Dictionary = load("res://player_limbs/player_torsos/standard.tres").data
	return stats
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
