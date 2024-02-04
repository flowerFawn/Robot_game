extends AnimatableBody2D 
var hit_limb:KinematicCollision2D
var damage:float
#goes that far per second
var speed:float
#will only hit bodies in that group
var targeted_group:String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	hit_limb = move_and_collide(Vector2(speed,0).rotated(rotation) * delta)
	if hit_limb != null and hit_limb.get_collider().get_parent().is_in_group(targeted_group):
		if hit_limb.get_collider().get_parent().is_in_group("player"):
			hit_limb.get_collider().limb_hp -= damage / 2
			
			hit_limb.get_collider().get_parent().total_hp -= damage / 2
			print(hit_limb.get_collider().get_parent().total_hp)
		elif hit_limb.get_collider().get_parent().is_in_group("enemy"):
			hit_limb.get_collider().get_parent().total_hp -= damage
		queue_free()
	elif hit_limb != null:
		queue_free()

