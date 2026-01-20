extends StaticBody2D

@export var key_color := "red"

func interact(player):
	player.collect_key(key_color)

	$Area2D.monitoring = false
	set_process(false)
