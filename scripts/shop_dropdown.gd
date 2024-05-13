extends OptionButton
var searched_folder = ("res://player_limbs/player_" + Temp_Vars.selected_shop_limb)
var selected_limb_name:String
var limb_folder
var limb_json
var owned_limb
var company_descriptions = {"Glorbcorp" : "Run by a clown. Profits driven into the ground. Every single product they have put out has been completely worthless, yet somehow it is still running"}
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
	var company
	var company_description
	limb_folder = DirAccess.open(searched_folder)
	owned_limb = is_limb_owned(index)
	if owned_limb:
		set_owned_item(true)
	else:
		set_owned_item(false)
	selected_limb_name = limb_folder.get_files()[index].left(-5)
	get_parent().get_node("LimbName").text = selected_limb_name
	limb_json = load(searched_folder + "/" + limb_folder.get_files()[index]).data
	print(limb_folder.get_files()[index])
	if limb_json.has("texture") and FileAccess.file_exists(limb_json["texture"]):
		get_parent().get_node("LimbSprite").texture = load(limb_json["texture"])
		get_parent().get_node("LimbSprite").scale = Vector2(5, 5)
	company = limb_json.get("company", "???")
	get_parent().get_node("CompanyName").text = company
	company_description = company_descriptions.get(company.to_lower(), "The serial number has been filed off, the source is unknown")
	get_parent().get_node("CompanyDescription").text = company_description
	
	
func purchase_item():
	var cost
	limb_json = load(searched_folder + "/" + selected_limb_name).data
	cost = limb_json.get("cost", 0)
	if cost == 0:
		print("that limb cost 0 scrap, are you sure you don't want to give it a price?")
	#in theory this should never run while it is an owned limb, but better safe than sorry innit
	print([selected_limb_name])
	if valid_purchase(cost):
		Game.game_info["scrap"] -= cost
		var saved_owned_limbs = load("res://saves/owned_" + Temp_Vars.selected_shop_limb + ".json").data
		print(selected_limb_name)
		saved_owned_limbs.append(selected_limb_name)
		print(saved_owned_limbs)
		var save_location = FileAccess.open("res://saves/owned_" + Temp_Vars.selected_shop_limb + ".json", FileAccess.WRITE)
		save_location.store_string(JSON.stringify(saved_owned_limbs, "\n\t"))
		Game.save_game()
		set_owned_item(true)
	#get_parent().get_node("LimbSprite").texture
	
func set_owned_item(owned_bool):
	get_parent().get_node("OwnedLabel").visible = owned_bool
	get_parent().get_node("BuyButton").disabled = owned_bool
	owned_limb = owned_bool

func valid_purchase(cost):
	if not owned_limb and selected_limb_name != "" and cost <= Game.game_info["scrap"]:
		return true
	else:
		return false
