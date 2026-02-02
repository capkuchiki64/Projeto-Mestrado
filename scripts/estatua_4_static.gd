extends StaticBody2D

signal estatua_interagida

@export var key_color := "green"

func interact(player):
	emit_signal("estatua_interagida", key_color)

	# opcional: impedir repetir
	$Area2D.monitoring = false
	set_process(false)
