extends Area2D

func _on_body_entered(body):
	print("Player entrou")
	if body.is_in_group("player"):
		body.can_interact = true
		body.interact_target = get_parent()
		print("Player entrou na área da estátua")

func _on_body_exited(body):
	print("Player saiu")
	if body.is_in_group("player"):
		body.can_interact = false
		body.interact_target = null
		print("Player saiu da área da estátua")
