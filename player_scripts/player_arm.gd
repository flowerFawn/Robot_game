extends StaticBody2D
@export var is_left: bool
const UNSHOOTABLE_STATES = ["disabled", "sliding", "climbing"]
var speed_multiplier: int
var limb_hp:float
# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	limb_hp = stats["hp"] * 2
	get_parent().add_stats(stats)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (get_parent().player_state not in UNSHOOTABLE_STATES and not get_parent().is_climbing) or is_left:
		look_at(get_global_mouse_position())

func decode_part_json():
	if is_left:
		var stats: Dictionary = load("res://player_limbs/player_arms/" + Selected_Limbs.parts["left_arm"]).data
		return stats
	else:
		var stats: Dictionary = load("res://player_limbs/player_arms/" + Selected_Limbs.parts["right_arm"]).data
		return stats

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
		
		
