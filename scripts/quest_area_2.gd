extends Area2D

@export var quest: CanvasLayer

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("📜 Player entrou na área da Quest")
		quest.abrir()
