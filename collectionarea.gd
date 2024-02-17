extends Area2D

var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start_slide(direction_multiplier):
	rotation_degrees = 90 * direction_multiplier
	
func end_slide(_direction_multiplier):
	rotation_degrees = 0


func _on_body_entered(body):
	body.apply_impulse(body.global_position.direction_to(self.global_position) * 300)



func _on_body_exited(body):
	Game.scrap += rng.randi_range(2, 5)
	body.queue_free()
