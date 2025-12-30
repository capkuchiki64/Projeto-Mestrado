extends Area2D

var player_inside := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	if body.name == "Player":
		player_inside = true
		print("Player entrou no puzzle")

func _on_body_exited(body: Node) -> void:
	if body.name == "Player":
		player_inside = false
		print("Player saiu do puzzle")

func _unhandled_input(event: InputEvent) -> void:
	if player_inside and Input.is_action_just_pressed("interacao"):
		print("Abrir puzzle 1")
		get_tree().change_scene_to_file("res://cenas/sandbox.tscn")
		
