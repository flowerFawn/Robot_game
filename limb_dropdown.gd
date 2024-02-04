extends OptionButton
@export var searched_folder:String
@export var assigned_limb:String
#snakecase
#put the folder link here (no "")
func _ready():
	#looks through the folder it is told too
	var limb_folder = DirAccess.open(searched_folder)
	#adds each file as a string without the .json text
	for file in limb_folder.get_files():
		file = file.left(-5)
		add_item(file)
	#selects nothing
	select(-1)
	

func _process(_delta):
	pass


func _on_item_selected(index):
	#reopens the folder
	var limb_folder = DirAccess.open(searched_folder)
	#gets the same index in the files as the index of the selected one, returning the correct limb :)
	Selected_Limbs.parts[assigned_limb] = limb_folder.get_files()[index]
