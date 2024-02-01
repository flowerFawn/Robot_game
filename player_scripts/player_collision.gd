extends CollisionShape2D


func start_slide(_direction_multiplier):
	rotation_degrees = 90
	position.y -= 4

func end_slide(_direction_multiplier):
	rotation_degrees = 0
	position.y += 4
