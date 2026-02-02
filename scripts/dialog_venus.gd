extends Area2D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))


func _on_body_entered(body):
	if body.name == "Player":
		print("Player entrou na área → mostrando diálogo")

		var dialog = $DialogBox_7
		dialog.reset_dialog()  # reinicia os textos SEMPRE
		dialog.show()

		# Desabilita a área para não ativar de novo
		set_deferred("monitoring", false)
