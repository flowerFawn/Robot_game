extends CanvasLayer

const hp_preset = "%s/%s"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	get_node("UIControl/HPBar").value = Player_Stats.player_current_hp
	get_node("UIControl/HPBar/HPLabel").text = hp_preset % [round(Player_Stats.player_current_hp), Player_Stats.player_total_hp]

func set_max():
	get_node("UIControl/HPBar").max_value = Player_Stats.player_total_hp

func switch_pause():
	visible = not get_tree().paused
