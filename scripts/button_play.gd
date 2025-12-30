extends Button

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://cenas/sandbox.tscn")


func _on_button_quit_pressed() -> void:
	pass
