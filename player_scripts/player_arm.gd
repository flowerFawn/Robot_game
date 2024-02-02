extends StaticBody2D
@export var is_left: bool
const UNSHOOTABLE_STATES = ["disabled", "sliding"]
var speed_multiplier: int
# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	get_parent().add_stats(stats)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().player_state not in UNSHOOTABLE_STATES or is_left:
		look_at(get_global_mouse_position())

func decode_part_json():
	var stats: Dictionary = load("res://player_limbs/player_arms/standard.json").data
	return stats

func start_slide(direction_multiplier):
	if not is_left:
		rotation_degrees = 150 
		position.y += 4
		position.x -= 4 * direction_multiplier
		if direction_multiplier == -1:
			position.x += 6
			rotation_degrees -= 90
	else:
		position.x -= 4
		
func end_slide(direction_multiplier):
	if not is_left:
		rotation_degrees = 0
		position.y -= 4
		position.x += 4 * direction_multiplier
		if direction_multiplier == -1:
			position.x -= 6
			rotation_degrees += 90
	else:
		position.x += 4
		
		
