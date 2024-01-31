extends StaticBody2D

var stats: Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	decode_part_json()


func decode_part_json():
	stats = load("res://player_limbs/player_legs/standard.tres").data
	print(stats)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
