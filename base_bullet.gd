extends AnimatableBody2D 
var hit_limb:KinematicCollision2D
var damage:float
#goes that far per second
var speed:float
#will only hit bodies in that group
var targeted_group:String

func _ready():
	pass


func _physics_process(delta):
	hit_limb = move_and_collide(Vector2(speed,0).rotated(rotation) * delta)
	if hit_limb != null and hit_limb.get_collider().get_parent().is_in_group(targeted_group):
		if hit_limb.get_collider().get_parent().is_in_group("player"):
			#total takes full damage, limb takes half
			hit_limb.get_collider().limb_hp -= damage / 2
			hit_limb.get_collider().get_parent().total_hp -= damage / 2
		elif hit_limb.get_collider().get_parent().is_in_group("enemy"):
			#total takes  full damage as enemies don't work based on individual limbs
			hit_limb.get_collider().get_parent().total_hp -= damage
		#removes itself
		queue_free()
	elif hit_limb != null:
		#if it hits something that isn't in the targeted group then it will also remove itself
		queue_free()

