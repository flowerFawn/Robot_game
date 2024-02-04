extends CharacterBody2D
const UNMOVABLE_STATES = ["disabled", "sliding"]
var player_state = "disabled"
var is_climbing:bool = false
var current_forces:Vector2
var total_weight:float = 0
var total_hp:float = 0
var total_speed:float = 40
var total_jump:float = 0
var stored_slide:float
func _ready():
	Player_Stats.player_current_hp = total_hp
	Player_Stats.player_total_hp = total_hp
	get_node("UIControl").set_max()
	player_state = "walking"
	current_forces = Vector2(0, 10)


func _physics_process(delta):
	#adds y speed if in the air
	if player_state not in UNMOVABLE_STATES and is_climbing:
		current_forces.y = take_climbing_input()
	else:
		add_gravity(delta)
	#checks if the player is inputting slide, and returns an array with 0 as a bool, and 1 as the multiplier (-1 or 1, passed to change the direction of slide effects)
	var slide_output:Array = take_slide_input()
	#if it was a slide
	if slide_output[0]:
		#sets the state and stores it
		player_state = "sliding"
		stored_slide = slide_output[1]
		#starts the slide forces
		current_forces = Vector2(total_speed * 2 * slide_output[1], 0)
		#tells every child to do its own part to start sliding, calls start_slide and passed the multiplier
		position.y += 6
		for limb in get_children():
			if limb.is_in_group("ray"):
				limb.position.y -= 12
			elif not limb.is_in_group("slide_excluded"):
				limb.start_slide(stored_slide)
	#does all the check movement checks
	elif player_state not in UNMOVABLE_STATES and not (not are_legs_on_floor() and is_climbing):
		current_forces.x = take_movement_inputs()
		current_forces.y -= take_jump_input()
	if not are_legs_on_floor() and is_climbing and abs(current_forces.x) > 1:
		current_forces.x -= 100 * delta
	#checks if the player is sliding and is slowed to 0, or has released slide 
	if (player_state == "sliding" and abs(current_forces).x < 1) or (Input.is_action_just_released("slide") and player_state == "sliding"):
		#sets state back, and does end_slide, undoing the start of the slide
		player_state = "walking"
		position.y -= 6
		for limb in get_children():
			if limb.is_in_group("ray"):	
				limb.position.y += 12
			elif not limb.is_in_group("slide_excluded"):
				limb.end_slide(stored_slide)
	#takes 10 per second away from the current forces x axis, multiplier to change direction
	if player_state == "sliding":
		current_forces.x -= 10 * delta * stored_slide
	Player_Stats.player_position = global_position
	move_and_collide(current_forces * delta)
	Player_Stats.player_current_forces = current_forces
	Player_Stats.player_is_climbing = is_climbing

func _process(delta):
	Player_Stats.player_current_hp = total_hp

func add_stats(limb_stats: Dictionary):
	#takes in the dictionary from a limbs json, and adds it to the totals
	total_weight += limb_stats.get("weight", 0.0)
	total_hp += limb_stats.get("hp", 0.0)
	total_speed *= limb_stats.get("speed", 1)
	total_jump += limb_stats.get("jump", 0)
	
func add_gravity(delta):
	#uses the floor ray like is_on_floor()
	if get_node("FloorRay").get_collider() == null or not get_node("FloorRay").get_collider().is_in_group("floor"):
		current_forces.y += total_weight * delta
	else:
		current_forces.y = 0

func take_movement_inputs():
	#returns a total  to set the speed to (only will be called when walking)
	var movement_total:float = 0
	if Input.is_action_pressed("left"):
		movement_total -= total_speed
	if Input.is_action_pressed("right"):
		movement_total += total_speed
	return movement_total

func take_jump_input():
	#if not jumping (or is not on the floor) will return 0 to be added, and if jumping and on the floor will add the total jump to the y movement
	if Input.is_action_just_pressed("jump") and are_legs_on_floor():
		return total_jump
	else:
		return 0
		
func take_slide_input():
	if Input.is_action_just_pressed("slide") and player_state not in UNMOVABLE_STATES and are_legs_on_floor():
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
		
func take_climbing_input():
	var movement_total:float = 0
	if Input.is_action_pressed("up"):
		movement_total -= total_speed
	if Input.is_action_pressed("down"):
		movement_total += total_speed
	return movement_total

func are_legs_on_floor():
	#uses the floorray and groups to see if touching the floor
	if get_node("FloorRay").get_collider() != null:
		if get_node("FloorRay").get_collider().is_in_group("floor"):
			return true
		else:
			return false
	else:
		return false
