extends Area2D

var liberado := false

func _on_body_entered(body):
	if not liberado:
		print("🚫 Segundo andar bloqueado")
		return

	if body.is_in_group("player"):
		print("⬆️ Indo para o segundo andar")
		get_tree().change_scene_to_file("res://cenas/andar_2.tscn")


func _on_patria_segundo_andar_liberado() -> void:
	liberado = true
	print("✅ Segundo andar liberado")
