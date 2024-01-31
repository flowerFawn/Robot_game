extends StaticBody2D
@export var is_left: bool
const UNSHOOTABLE_STATES = ["disabled", "sliding"]
var speed_multiplier: int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if get_parent().player_state not in UNSHOOTABLE_STATES or is_left:
		look_at(get_global_mouse_position())
