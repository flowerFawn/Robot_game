extends StaticBody2D
const MAX_HP = 50
var hp = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("head_action"):
		collision_layer = 0
		collision_mask = 0
		var alpha_tweener = create_tween()
		alpha_tweener.tween_property(self, "modulate:a", 0, 0.5)
		await get_tree().create_timer(0.5).timeout
		queue_free()

func take_damage(damage):
	print("test")
	hp = clamp(hp - damage, 0, MAX_HP)
	process_modulation(hp)
	if hp == 0:
		await get_tree().create_timer(0.2).timeout
		queue_free()
	
	
func process_modulation(new_hp):
	var alpha_tweener = create_tween()
	alpha_tweener.tween_property(self, "modulate:a", clamp((new_hp / MAX_HP), 0, 1), 0.2)
	print(modulate)
