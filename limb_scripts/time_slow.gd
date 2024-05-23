extends Node
var time_stored:float = 10
var is_time_slowed:bool = false


func _init():
	#makes process start
	print("test")
	set_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("head_action"):
		var starting_slowdown_tween = create_tween()
		is_time_slowed = true
		starting_slowdown_tween.tween_property(Engine, "time_scale", 0.5, 1)
		starting_slowdown_tween.parallel().tween_property(get_parent().get_parent().get_parent(), "modulate", Color(0.75, 0.75, 1, 1), 1)
	elif Input.is_action_just_released("head_action") or time_stored == 0:
		var ending_slowdown_tween = create_tween()
		is_time_slowed = false
		ending_slowdown_tween.tween_property(Engine, "time_scale", 1, 1)
		ending_slowdown_tween.parallel().tween_property(get_parent().get_parent().get_parent(), "modulate", Color(1, 1, 1, 1), 1)
		get_parent().get_parent().get_parent().modulate = Color(1, 1, 1, 1)
	if not is_time_slowed:
		time_stored = clamp(time_stored + delta / 4, 0, 10)
	else:
		time_stored = clamp(time_stored - delta, 0, 10)
	print(time_stored)
