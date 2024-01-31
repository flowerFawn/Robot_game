extends CharacterBody2D
var player_state = "disabled"
var current_forces: Vector2
var total_weight:float = 0
var total_hp:float = 0
var total_speed:float = 50
# Called when the node enters the scene tree for the first time.
func _ready():
	player_state = "walking"
	current_forces = Vector2(0, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_node("FloorRay").get_collider() == null or not get_node("FloorRay").get_collider().is_in_group("floor"):
		current_forces.y += total_weight * delta
	else:
		current_forces.y = 0
	move_and_collide(current_forces * delta)

func add_stats(limb_stats: Dictionary):
	total_weight += limb_stats.get("weight", 0.0)
	total_hp += limb_stats.get("hp", 0.0)
	total_speed *= limb_stats.get("speed", 1)
	
