extends Node2D
var current_interactable:String = "none"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#if the user interacts
	if Input.is_action_just_pressed("interact"):
		#if the user is currently in the workbench or exits interaction area
		if current_interactable == "exit":
			get_tree().change_scene_to_file("res://spawn_level.tscn")
		elif current_interactable == "workbench":
			get_tree().change_scene_to_file("res://limb_menu.tscn")
			
func out_of_interactable_range(body):
	if body.is_in_group("player"):
		current_interactable = "none"


func _on_exit_interactable_body_entered(body):
	if body.is_in_group("player"):
		current_interactable = "exit"
		



func _on_work_table_interacable_body_entered(body):
	if body.is_in_group("player"):
		current_interactable = "workbench"
