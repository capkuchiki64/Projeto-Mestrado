extends Node2D

@export var puzzle_scene: PackedScene

@onready var dialogo_inicial := $Estatuas/Estatua_1/Dialogo_1/DialogBox
@onready var dialogo_final := $Dialogo_1/DialogBox_2


func _ready():
	dialogo_inicial.dialogo_puzzle_chamado.connect(_abrir_puzzle)
	dialogo_final.dialogo_finalizado.connect(_fim_dialogo_final)

	dialogo_inicial.start()


func _abrir_puzzle():
	print("🧩 Abrindo puzzle")

	var puzzle = puzzle_scene.instantiate()
	add_child(puzzle)

	puzzle.puzzle_finalizado.connect(_puzzle_concluido)


func _puzzle_concluido():
	print("🔁 Puzzle finalizado → diálogo final")
	dialogo_final.start()


func _fim_dialogo_final():
	print("✅ Fluxo completo — jogo continua")
