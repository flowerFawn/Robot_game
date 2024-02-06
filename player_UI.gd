extends Control

const hp_preset = "%s/%s"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	$HPBar.value = Player_Stats.player_current_hp
	get_node("HPBar/HPLabel").text = hp_preset % [round(Player_Stats.player_current_hp), Player_Stats.player_total_hp]

func set_max():
	$HPBar.max_value = Player_Stats.player_total_hp
