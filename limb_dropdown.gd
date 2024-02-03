extends OptionButton
@export var searched_folder:String
@export var assigned_limb:String
#snakecase
#put the folder link here (no "")
func _ready():
	
	var limb_folder = DirAccess.open(searched_folder)
	for file in limb_folder.get_files():
		file = file.left(-5)
		add_item(file)
	select(-1)
	print(limb_folder.get_files())
	

func _process(delta):
	pass


func _on_item_selected(index):
	var limb_folder = DirAccess.open(searched_folder)
	print(limb_folder.get_files()[index])
	Selected_Limbs.parts[assigned_limb] = limb_folder.get_files()[index]
