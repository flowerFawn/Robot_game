extends CharacterBody2D
const UNMOVABLE_STATES = ["disabled", "sliding"]
var player_state = "disabled"
var current_forces: Vector2
var total_weight:float = 0
var total_hp:float = 0
var total_speed:float = 40
var total_jump:float = 0
var stored_slide:float
# Called when the node enters the scene tree for the first time.
func _ready():
	player_state = "walking"
	current_forces = Vector2(0, 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	add_gravity(delta)
	var slide_output:Array = take_slide_input()
	if slide_output[0]:
		player_state = "sliding"
		stored_slide = slide_output[1]
		current_forces = Vector2(total_speed * 2 * slide_output[1], 0)
		for limb in get_children():
			if limb.is_in_group("ray"):
				limb.position.y -= 12
			elif not limb.is_in_group("slide_excluded"):
				limb.start_slide(stored_slide)
				print(stored_slide)
	elif player_state not in UNMOVABLE_STATES:
		current_forces.x = take_movement_inputs()
		current_forces.y -= take_jump_input()
	if (player_state == "sliding" and current_forces.x < 1) or (Input.is_action_just_released("slide") and player_state == "sliding"):
		player_state = "walking"
		for limb in get_children():
			if limb.is_in_group("ray"):	
				limb.position.y += 12
			elif not limb.is_in_group("slide_excluded"):
				limb.end_slide(stored_slide)
	if player_state == "sliding":
		current_forces.x -= 10 * delta
	move_and_collide(current_forces * delta)

func add_stats(limb_stats: Dictionary):
	total_weight += limb_stats.get("weight", 0.0)
	total_hp += limb_stats.get("hp", 0.0)
	total_speed *= limb_stats.get("speed", 1)
	total_jump += limb_stats.get("jump", 0)
	
func add_gravity(delta):
	if get_node("FloorRay").get_collider() == null or not get_node("FloorRay").get_collider().is_in_group("floor"):
		current_forces.y += total_weight * delta
	else:
		current_forces.y = 0

func take_movement_inputs():
	var movement_total:float = 0
	if Input.is_action_pressed("left"):
		movement_total -= total_speed
	if Input.is_action_pressed("right"):
		movement_total += total_speed
	return movement_total

func take_jump_input():
	if get_node("FloorRay").get_collider() != null:
		if Input.is_action_just_pressed("jump") and get_node("FloorRay").get_collider().is_in_group("floor"):
			return total_jump
		else:
			return 0
	else:
		return 0
		
func take_slide_input():
	if get_node("FloorRay").get_collider() != null:
		if Input.is_action_just_pressed("slide") and player_state not in UNMOVABLE_STATES and get_node("FloorRay").get_collider().is_in_group("floor"):
			if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
				return [false]
			elif Input.is_action_pressed("left"):
				return [true, -1]
			elif Input.is_action_pressed("right"):
				return [true, 1]
		else:
			return [false]
	else:
		return [false]
