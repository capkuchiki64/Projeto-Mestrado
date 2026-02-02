extends StaticBody2D

signal estatua_interagida(puzzle_scene: PackedScene, key_color: String)

@export var puzzle_scene: PackedScene
@export var key_color: String = "blue"

func interact(player):
	print("🗿 Estátua interagida | Puzzle:", puzzle_scene, "| Chave:", key_color)

	emit_signal("estatua_interagida", puzzle_scene, key_color)

	# opcional: impedir repetir
	if has_node("Area2D"):
		$Area2D.monitoring = false

	set_process(false)
