extends Node
var hp_increase = 1
func _init():
	#makes process start
	set_process(true)

func _process(delta):
	#adds 1 hp to the player per second
	get_parent().get_parent().current_hp += hp_increase * delta
	
func set_script_stats(read_stat):
	hp_increase = read_stat
