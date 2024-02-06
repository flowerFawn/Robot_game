extends Node



func _process(delta):
	#adds 1 hp to the player per second
	get_parent().get_parent().current_hp += 1 * delta

