extends Node2D

@export var puzzle_scene: PackedScene

@onready var dialogo_inicial: Control = $Estatuas/Estatua_1/Dialogo_1/DialogBox
@onready var dialogo_inicial2: Control = $Estatuas/Estatua_1/Dialogo_1/DialogBox
@onready var estatua_area := $Estatuas/Estatua_1/Area2D
@onready var estatua_area2 := $Estatuas/Estatua_1/Area2D
@onready var dialogo_resultado := $Dialogo_1/DialogBox_2
@onready var dialogo_resultado2 := $Dialogo_1/DialogBox_2
@onready var quest_1 := $Quest_1
@onready var quest_2 := $Quest_2

var acertou := false

func _ready():
	
	# Quest
	quest_1.resposta_escolhida.connect(_on_resposta_escolhida)
	quest_2.resposta_escolhida.connect(_on_resposta_escolhida)

	# Diálogo inicial → puzzle
	dialogo_inicial.dialogo_puzzle_chamado.connect(_abrir_puzzle)
	dialogo_inicial2.dialogo_puzzle_chamado.connect(_abrir_puzzle)

	# Puzzle → diálogo final
	dialogo_resultado.dialogo_finalizado.connect(_on_dialogo_finalizado)
	dialogo_resultado2.dialogo_finalizado.connect(_on_dialogo_finalizado)
	
	estatua_area.player_entrou.connect(_on_player_entrou_estatua)
	estatua_area.player_saiu.connect(_on_player_saiu_estatua)
	estatua_area2.player_entrou.connect(_on_player_entrou_estatua)
	estatua_area2.player_saiu.connect(_on_player_saiu_estatua)

	# segurança
	dialogo_inicial.visible = false
	dialogo_resultado.visible = false
	dialogo_inicial2.visible = false
	dialogo_resultado2.visible = false
	print("Dialogo inicial =", dialogo_inicial)
	
# =========================
# QUEST
# =========================
func _on_resposta_escolhida(correta: bool):
	if correta:
		print("✔ Resposta correta → abrir diálogo inicial")
		dialogo_inicial.start()
	else:
		print("❌ Resposta errada → não abre diálogo inicial")
		
func _on_resposta_escolhida2(correta: bool):
	if correta:
		print("✔ Resposta correta → abrir diálogo inicial")
		dialogo_inicial2.start()
	else:
		print("❌ Resposta errada → não abre diálogo inicial")

# =========================
# PUZZLE
# =========================
func _abrir_puzzle():
	print("🧩 Abrindo puzzle")

	var puzzle = puzzle_scene.instantiate()
	add_child(puzzle)

	puzzle.puzzle_finalizado.connect(_on_puzzle_finalizado)

func _abrir_puzzle2():
	print("🧩 Abrindo puzzle")

	var puzzle2 = puzzle_scene.instantiate()
	add_child(puzzle2)

	puzzle2.puzzle_finalizado.connect(_on_puzzle_finalizado)

func _on_puzzle_finalizado():
	print("🎉 Puzzle finalizado → diálogo correto")
	dialogo_resultado.start_certo()
	
func _on_puzzle2_finalizado():
	print("🎉 Puzzle finalizado → diálogo correto")
	dialogo_resultado2.start_certo()


# =========================
# FINAL
# =========================
func _on_dialogo_finalizado():
	print("✅ Fluxo encerrado")

func _on_player_entrou_estatua():
	print("📜 Player pode interagir com a estátua")
	quest_1.visible = true   # abre escolha da chave

func _on_player_saiu_estatua():
	print("❌ Player saiu da estátua")
	quest_1.visible = false

func _on_dialogo2_finalizado():
	print("✅ Fluxo encerrado")

func _on_player_entrou_estatua2():
	print("📜 Player pode interagir com a estátua")
	quest_2.visible = true   # abre escolha da chave

func _on_player_saiu_estatua2():
	print("❌ Player saiu da estátua")
	quest_2.visible = false
