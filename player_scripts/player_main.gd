extends CharacterBody2D
var player_state = "disabled"
var current_forces: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	player_state = "walking"
	current_forces = Vector2(0, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if get_node("FloorRay").get_collider() == null or not get_node("FloorRay").get_collider().is_in_group("floor"):
		current_forces.y += 50 * delta
	else:
		current_forces.y = 0
	move_and_collide(current_forces * delta)
