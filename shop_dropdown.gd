extends OptionButton


# Called when the node enters the scene tree for the first time.
func _ready():
	#looks through the folder it is told too
	var limb_folder = DirAccess.open(searched_folder)
	#adds each file as a string without the .json text
	for file in limb_folder.get_files():
		file = file.left(-5)
		add_item(file)
	#selects nothing
	select(-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
