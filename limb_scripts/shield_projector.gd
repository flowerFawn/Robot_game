extends Node
var cooldown:bool = false
const shield_projectile:PackedScene = preload("res://instanceables/projectiles/shield.tscn")
func _init():
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("head_action") and cooldown == false:
		var new_shield = shield_projectile.instantiate()
		new_shield.global_position = get_parent().global_position
		new_shield.modulate.a = 0.1
		new_shield.scale = Vector2(0.1, 0.1)
		get_parent().get_parent().get_parent().get_node("Bullets").add_child(new_shield)
		cooldown = true
		await get_tree().create_timer(5).timeout
		cooldown = false
