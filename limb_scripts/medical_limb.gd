extends Node

func _init():
	#makes process start
	set_process(true)

func _process(delta):
	#adds 1 hp to the player per second
	get_parent().get_parent().current_hp += 1 * delta
	print(get_parent().get_parent())
	print("test")
