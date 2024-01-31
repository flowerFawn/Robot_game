extends StaticBody2D
var player_state = "disabled"
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	player_state = "walking"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2(0,10)
	move_and_collide(velocity * delta)


