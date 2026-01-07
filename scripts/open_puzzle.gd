extends Area2D

@export var puzzle_scene: PackedScene


func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.is_in_group("player"):
		body.can_interact = true
		body.interact_target = self
		print("Player pode interagir")


func _on_body_exited(body):
	if body.is_in_group("player"):
		body.can_interact = false
		body.interact_target = null
		print("Player saiu da área")


func interact():
	print("Interagiu!")
	if puzzle_scene:
		get_tree().change_scene_to_packed(puzzle_scene)
