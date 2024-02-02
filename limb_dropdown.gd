extends OptionButton
@export var searched_folder:String
var limb_folder = DirAccess.open("res://player_limbs/player_legs")
# Called when the node enters the scene tree for the first time.
func _ready():
	print(limb_folder)
	print(searched_folder)
	print(limb_folder.get_files())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
