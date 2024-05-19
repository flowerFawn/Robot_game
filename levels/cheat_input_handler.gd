extends LineEdit
var checked_text:String
var _CHEAT_CODES = {
	"diablo" : test_cheat,
	"idkfa" : toggle_access_all
	
	}

func display_cheat_text(text):
	get_node("CheatTextDisplay").text = text
	await get_tree().create_timer(2.0).timeout
	get_node("CheatTextDisplay").text = ""


func _ready():
	grab_focus()

func toggle_access_all():
	Cheat_Handler.access_all = not Cheat_Handler.access_all
	if Cheat_Handler.access_all == true:
		display_cheat_text("you can access all limbs")
	else:
		display_cheat_text("you can no longer access all limbs")


func test_cheat():
	display_cheat_text("I'm a god. \nI call myself Diablo the Cheater. As far as I know, I'm the only person who writes a list of cheating cheats and uses it in-game. My mod turned the game into an interdimensional gay simulator (powered by a fucking necromancer), and I use that game on a daily basis. To date, I've cheated thirty games. Twenty-one of them were developed by other users, and the other two were made by me. \nAnd today, this motherfucker is named after me. \nI use a relatively simple cheat to game console games. What I do is turn the switch on the controller I use into a button on the console, and then I press it to trigger cheats that give me a better experience. Here's what those che")

func _on_text_changed(new_text):

	check_for_cheat_code(text)

func check_for_cheat_code(text):
	for cheat_code in _CHEAT_CODES:
		checked_text = text.right(len(cheat_code))
		if checked_text == cheat_code:
			_CHEAT_CODES[cheat_code].call()
