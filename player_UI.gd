extends Control

const hp_preset = "%s/%s"
# Called when the node enters the scene tree for the first time.
func _ready():
	$HPBar.max_value = Player_Stats.player_total_hp
	$HPBar.value = Player_Stats.player_total_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HPBar.value = Player_Stats.player_current_hp
	$HPLabel.text = hp_preset % [Player_Stats.player_current_hp, Player_Stats.player_total_hp]
