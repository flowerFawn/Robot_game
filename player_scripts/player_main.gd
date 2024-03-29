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
var slide_multiplier:float = 2
var current_hp:float
var current_parts:Array = ["head", "left_leg", "right_leg", "left_arm", "right_arm"]
@export var camera_disabled:bool = false

func _ready():
	Player_Stats.player_current_hp = total_hp
	Player_Stats.player_total_hp = total_hp
	#gets the UI if it exists and calls set_max on it
	if get_parent().get_parent().has_node("UIControl"):
		get_parent().get_parent().get_node("UIControl").set_max()
	player_state = "walking"
	current_forces = Vector2(0, 0)
	if camera_disabled:
		get_node("PlayerCamera").enabled = false


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
		run_slide(slide_output)
	#does all the movement checks
	#runs if the player_state isn't an unmoveable state (such as sliding or disabled) and they are on the floor, while in a ladder, or just not in a ladder, or that they are in the air with only one leg
	elif can_walk():
		current_forces.x = take_movement_inputs()
	elif player_state == "walking":
		current_forces.x = 0
	if are_legs_on_floor():
		current_forces.y -= take_jump_input()
	#if the player is not on the floor, and they are climbing, they will slow down (smoothes it out a lot, looks much prettier
	if not are_legs_on_floor() and is_climbing and abs(current_forces.x) > 1:
		current_forces.x -= 100 * delta
	#checks if the player is sliding and is slowed to 0, or has released slide 
	if (player_state == "sliding" and abs(current_forces).x < 1) or (Input.is_action_just_released("slide") and player_state == "sliding"):
		#sets state back, and does end_slide on each limb, undoing the start of the slide
		run_end_slide()
	#takes 10 per second away from the current forces x axis, multiplier to change direction
	if player_state == "sliding":
		current_forces.x -= 10 * delta * stored_slide
	run_zooming()
	Player_Stats.player_position = global_position
	move_and_collide(current_forces * delta)
	Player_Stats.player_current_forces = current_forces
	Player_Stats.player_is_climbing = is_climbing

func _process(_delta):
	current_hp = clamp(current_hp, -10000000, total_hp)
	Player_Stats.player_current_hp = current_hp
	if current_hp < 0 or not (current_parts.has("left_leg") and current_parts.has("right_leg")):
		die()

func add_stats(limb_stats: Dictionary, added_limb):
	#takes in the dictionary from a limbs json, and adds it to the totals
	total_weight += limb_stats.get("weight", 0.0)
	total_hp += limb_stats.get("hp", 0.0)
	total_speed *= limb_stats.get("speed", 1)
	total_jump += limb_stats.get("jump", 0)
	#gets the limbs script (if it has one) and runs its editing main stats (if it has one)
	if added_limb.has_node("ScriptHost"):
		if added_limb.get_node("ScriptHost").has_method("edit_main_stats"):
			added_limb.get_node("ScriptHost").edit_main_stats()
	current_hp = total_hp
	
func remove_stats(limb_stats: Dictionary, removed_limb):
	current_parts.pop_at(current_parts.find(removed_limb.limb_id))
	#takes in the dictionary from a limbs json, and removes it from the totals (called when a limb is destroyed)
	total_weight -= limb_stats.get("weight", 0.0)
	total_speed /= limb_stats.get("speed", 1)
	total_jump -= limb_stats.get("jump", 0)


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

func die():
	pass
	#print("you dead :(")

func run_slide(slide_output):
	#sets the state and stores it
	player_state = "sliding"
	stored_slide = slide_output[1]
	#starts the slide forces
	current_forces = Vector2(total_speed * slide_multiplier * slide_output[1], 0)
	#tells every child to do its own part to start sliding, calls start_slide and passed the multiplier
	position.y += 6
	for limb in get_children():
		if limb.is_in_group("ray"):
			limb.position.y -= 12
		elif not limb.is_in_group("slide_excluded"):
			limb.start_slide(stored_slide)

func run_end_slide():
	player_state = "walking"
	position.y -= 6
	for limb in get_children():
		if limb.is_in_group("ray"):	
			limb.position.y += 12
		elif not limb.is_in_group("slide_excluded"):
			limb.end_slide(stored_slide)
			
func can_walk():
	#elif player_state not in UNMOVABLE_STATES and ((not (not are_legs_on_floor() and is_climbing) and current_parts.has("left_leg") and current_parts.has("right_leg")) or (not current_parts.has("left_leg") or not current_parts.has("right_leg") and not are_legs_on_floor())):
	if player_state not in UNMOVABLE_STATES:
		if not (not are_legs_on_floor() and is_climbing):
			if current_parts.has("left_leg") and current_parts.has("right_leg"):
				return true
			elif not are_legs_on_floor():
				return true
			else:
				return false
		else:
			return false
	else:
		return false

func run_zooming():
	get_node("PlayerCamera").offset.y = (get_node("PlayerCamera").zoom.y * 8)
	if Input.is_action_just_released("zoom_in") and not Input.is_action_just_released("zoom_out"):
		var zooming_tween = create_tween()
		zooming_tween.tween_property(get_node("PlayerCamera"), "zoom", Vector2(clamp(ceil(get_node("PlayerCamera").zoom.x + 1), 3, 10),clamp(ceil(get_node("PlayerCamera").zoom.y + 1), 3, 10)), 0.25)
		
	elif Input.is_action_just_released("zoom_out"):
		var zooming_tween = create_tween()
		zooming_tween.tween_property(get_node("PlayerCamera"), "zoom", Vector2(clamp(floor(get_node("PlayerCamera").zoom.x - 1), 3, 10),clamp(floor(get_node("PlayerCamera").zoom.y - 1), 3, 10)), 0.25)
