extends StaticBody2D
@export var is_left:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	get_parent().add_stats(stats)

func decode_part_json():
	var stats: Dictionary = load("res://player_limbs/player_legs/standard.json").data
	return stats
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
	
func _process(delta):
	pass
