extends AnimatableBody2D
var hit_limb:KinematicCollision2D
#damage it does
var damage:float
#goes that far per second
var speed:float
#will only hit bodies in that group
var targeted_group:String
var gain_damage:bool
var gain_speed:bool
func _ready():
	pass


func _physics_process(delta):
	if gain_speed == true:
		speed += delta * 10
	if gain_damage == true:
		damage += delta * 10
	hit_limb = move_and_collide(Vector2(speed * delta,0).rotated(rotation))
	if (hit_limb != null and hit_limb.get_collider().get_parent().is_in_group(targeted_group)) or (hit_limb != null and hit_limb.get_collider().is_in_group("all_hit")):
		if hit_limb.get_collider().get_parent().is_in_group("player") or hit_limb.get_collider().is_in_group("shield"):
			#total takes full damage, limb takes half
			hit_limb.get_collider().take_damage(damage)
			print("test")
		elif hit_limb.get_collider().get_parent().is_in_group("enemy"):
			#total takes full damage
			hit_limb.get_collider().get_parent().take_damage(damage)
		#removes itself
		queue_free()
	elif hit_limb != null:
		#if it hits something that isn't in the targeted group then it will also remove itself
		queue_free()



func _on_time_to_despawn_timeout():
	queue_free()
