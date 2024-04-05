extends Control

func _on_respawn_pressed():
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")

func _on_return_to_title_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
