extends Node2D
@export var is_left:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	var stats: Dictionary
	stats = decode_part_json()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func decode_part_json():
	if is_left:
		var stats: Dictionary = load("res://player_limbs/player_arms/" + Selected_Limbs.parts["left_weapon"]).data
	else:
		var stats: Dictionary = load("res://player_limbs/player_arms/" + Selected_Limbs.parts["right_weapon"]).data
