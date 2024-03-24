extends Node2D
var current_interactable:String = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if the user interacts
	if Input.is_action_just_pressed("interact") and current_interactable != "none":
		#if the user is currently in the workbench or exits interaction area
		get_tree().change_scene_to_file(current_interactable)
			
func out_of_interactable_range(body):
	if body.is_in_group("player"):
		current_interactable = "none"


func _on_exit_interactable_body_entered(body):
	if body.is_in_group("player"):
		current_interactable = "res://spawn_level.tscn"


func _on_work_table_interacable_body_entered(body):
	if body.is_in_group("player"):
		current_interactable = "res://limb_menu.tscn"


func _on_shop_interactable_body_entered(body):
	if body.is_in_group("player"):
		current_interactable = "res://shop_selector_menu.tscn"
