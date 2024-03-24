extends OptionButton
var searched_folder = ("res://player_limbs/player_" + Temp_Vars.selected_shop_limb)

# Called when the node enters the scene tree for the first time.
func _ready():
	#looks through the folder it is told too
	print(searched_folder)
	var limb_folder = DirAccess.open(searched_folder)
	print(limb_folder)
	#adds each file as a string without the .json text
	for file in limb_folder.get_files():
		file = file.left(-5)
		add_item(file)
	#selects nothing
	select(-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_selected(index):
	var limb_folder = DirAccess.open(searched_folder)
	var limb_json = load(searched_folder + "/" + limb_folder.get_files()[index]).data
	print(limb_folder.get_files()[index])
	if limb_json.has("texture") and load(limb_json["texture"]) != null:
		get_parent().get_node("LimbSprite").texture = load(limb_json["texture"])
		get_parent().get_node("LimbSprite").scale = Vector2(5, 5)
	
	#get_parent().get_node("LimbSprite").texture
