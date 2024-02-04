extends Area2D


func _ready():
	pass


func _process(delta):
	pass


func _on_body_entered(body):
	#tells the player they are climbing, if it is the player
	if body.is_in_group("player"):
		body.is_climbing = true


func _on_body_exited(body):
	#tells them they are no longer climbing, and slows down their y so they don't go flying
	if body.is_in_group("player"):
		body.is_climbing = false
		body.current_forces.y *= 0.25
