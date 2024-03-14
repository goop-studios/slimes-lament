extends Control

func _on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/node_3d.tscn")

func _on_options_placeholder_pressed():
	get_tree().change_scene_to_file("res://scenes/options.tscn")

func _on_exit_pressed():
	get_tree().quit()
