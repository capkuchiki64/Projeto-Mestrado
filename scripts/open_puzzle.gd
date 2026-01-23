extends Area2D

@export var puzzle_scene: PackedScene

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.can_interact = true
		body.interact_target = get_parent()

func _on_body_exited(body):
	if body.is_in_group("player"):
		body.can_interact = false
		body.interact_target = null
