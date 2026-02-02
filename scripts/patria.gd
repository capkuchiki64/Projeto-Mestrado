extends Area2D

signal player_entrou
signal player_saiu

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("🗿 Player entrou na área da estátua")
		emit_signal("player_entrou")

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("🚶 Player saiu da área da estátua")
		emit_signal("player_saiu")
