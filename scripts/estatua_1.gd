extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("PLAYER ENTROU NA AREA")
		body.interact_target = owner

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("PLAYER SAIU DA AREA")
		if body.interact_target == owner:
			body.interact_target = null
