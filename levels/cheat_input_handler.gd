extends LineEdit
var checked_text:String
var _CHEAT_CODES = {
	"diablo" : test_cheat,
	"idkfa" : toggle_access_all
	
	}

func _ready():
	grab_focus()

func toggle_access_all():
	Cheat_Handler.access_all = not Cheat_Handler.access_all


func test_cheat():
	print("my name is diablo the cheater")

func _on_text_changed(new_text):

	check_for_cheat_code(text)

func check_for_cheat_code(text):
	for cheat_code in _CHEAT_CODES:
		checked_text = text.right(len(cheat_code))
		if checked_text == cheat_code:
			_CHEAT_CODES[cheat_code].call()
