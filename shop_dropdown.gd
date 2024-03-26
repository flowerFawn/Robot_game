extends OptionButton
var searched_folder = ("res://player_limbs/player_" + Temp_Vars.selected_shop_limb)
var selected_limb_name:String
var limb_folder
var limb_json
var owned_limb
# Called when the node enters the scene tree for the first time.
func _ready():
	#looks through the folder it is told too
	#print(searched_folder)
	limb_folder = DirAccess.open(searched_folder)
	#print(limb_folder)
	#adds each file as a string without the .json text
	for file in limb_folder.get_files():
		file = file.left(-5)
		add_item(file)
	#selects nothing
	select(-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func is_limb_owned(index):
	var saved_limbs_file = load("res://saves/owned_" + Temp_Vars.selected_shop_limb + ".json")
	#print(saved_limbs_folder)
	if limb_folder.get_files()[index].left(-5) in saved_limbs_file.data:
		return true
	else:
		return false
		
func _on_item_selected(index):
	limb_folder = DirAccess.open(searched_folder)
	owned_limb = is_limb_owned(index)
	if owned_limb:
		set_owned_item(true)
	else:
		set_owned_item(false)
	selected_limb_name = limb_folder.get_files()[index].left(-5)
	limb_json = load(searched_folder + "/" + limb_folder.get_files()[index]).data
	print(limb_folder.get_files()[index])
	if limb_json.has("texture") and FileAccess.file_exists(limb_json["texture"]):
		get_parent().get_node("LimbSprite").texture = load(limb_json["texture"])
		get_parent().get_node("LimbSprite").scale = Vector2(5, 5)
	
func purchase_item():
	#in theory this should never run while it is an owned limb, but better safe than sorry innit
	print([selected_limb_name])
	if not owned_limb and selected_limb_name != "":
		var saved_owned_limbs = load("res://saves/owned_" + Temp_Vars.selected_shop_limb + ".json").data
		print(selected_limb_name)
		saved_owned_limbs.append(selected_limb_name)
		print(saved_owned_limbs)
		var save_location = FileAccess.open("res://saves/owned_" + Temp_Vars.selected_shop_limb + ".json", FileAccess.WRITE)
		save_location.store_string(JSON.stringify(saved_owned_limbs, "\n"))
		set_owned_item(true)
	#get_parent().get_node("LimbSprite").texture
	
func set_owned_item(owned_bool):
	get_parent().get_node("OwnedLabel").visible = owned_bool
	get_parent().get_node("BuyButton").disabled = owned_bool
	owned_limb = owned_bool
