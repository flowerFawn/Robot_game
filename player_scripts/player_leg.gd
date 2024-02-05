extends StaticBody2D
@export var is_left:bool
var limb_hp:float
# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()
	limb_hp = stats["hp"]
	get_parent().add_stats(stats)

func decode_part_json():
	#uses selected limbs to get the selected limb and then the json for it
	if is_left:
		var stats: Dictionary = load("res://player_limbs/player_legs/" + Selected_Limbs.parts["left_leg"]).data
		return stats
	else:
		var stats: Dictionary = load("res://player_limbs/player_legs/" + Selected_Limbs.parts["right_leg"]).data
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
	get_parent().total_hp -= damage
