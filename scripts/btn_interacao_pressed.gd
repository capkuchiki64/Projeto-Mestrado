extends Button

func _process(_delta):
	if Input.is_action_just_pressed("interacao"):
		print("Interagiu")


func _on_pressed() -> void:
	print("Interagiu")
