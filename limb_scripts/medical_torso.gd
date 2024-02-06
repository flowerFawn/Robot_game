extends Node

func _init():
	#makes process start
	set_process(true)
	
func _process(delta):
	#adds 5 hp to the player per second
	get_parent().get_parent().current_hp += 5 * delta

