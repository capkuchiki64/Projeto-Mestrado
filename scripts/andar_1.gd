extends Node2D

# =========================
# NÓS
# =========================

@onready var estatua_2 := $Estatuas/Estatua_2
@onready var estatua_5 := $Estatuas/Estatua_5

@onready var dialogo_inicial: Control = $Estatuas/Estatua_1/Dialogo_1/DialogBox
@onready var dialogo_resultado: Control = $Dialogo_1/DialogBox_2

@onready var estatua_area := $Estatuas/Estatua_1/Area2D

@onready var quest_1 := $Quest_1
@onready var quest_2 := $Quest_2
@onready var quest_3 := $Quest_3
@onready var quest_4 := $Quest_4


# =========================
# ESTADO
# =========================

var puzzle_aberto := false
var chave_pendente : String = ""
var puzzle_pendente : PackedScene


# =========================
# READY
# =========================

func _ready():
	# Estátuas
	estatua_2.estatua_interagida.connect(_on_estatua_interagida)
	estatua_5.estatua_interagida.connect(_on_estatua_interagida)

	# Quests
	quest_1.resposta_escolhida.connect(_on_resposta_escolhida)
	quest_2.resposta_escolhida.connect(_on_resposta_escolhida)
	quest_3.resposta_escolhida.connect(_on_resposta_escolhida)
	quest_4.resposta_escolhida.connect(_on_resposta_escolhida)

	# Diálogo final
	dialogo_resultado.dialogo_finalizado.connect(_on_dialogo_finalizado)

	# Área da estátua
	estatua_area.player_entrou.connect(_on_player_entrou_estatua)
	estatua_area.player_saiu.connect(_on_player_saiu_estatua)

	# Segurança
	dialogo_inicial.visible = false
	dialogo_resultado.visible = false
	quest_1.visible = false

	print("✔ Andar iniciado corretamente")


# =========================
# QUEST
# =========================

func _on_resposta_escolhida(correta: bool):
	if correta:
		print("✔ Resposta correta → abrir diálogo inicial")
		dialogo_inicial.start()
	else:
		print("❌ Resposta errada → não abre diálogo")


# =========================
# ESTÁTUA
# =========================

func _on_estatua_interagida(puzzle_scene: PackedScene, key_color: String):
	print("🗿 Estátua ativada → puzzle específico")

	chave_pendente = key_color
	puzzle_pendente = puzzle_scene

	_abrir_puzzle(puzzle_pendente)


# =========================
# PUZZLE
# =========================

func _abrir_puzzle(puzzle_scene: PackedScene):
	if puzzle_aberto:
		return

	puzzle_aberto = true
	print("🧩 Abrindo puzzle:", puzzle_scene)

	var puzzle = puzzle_scene.instantiate()
	add_child(puzzle)

	puzzle.puzzle_finalizado.connect(_on_puzzle_finalizado)


func _on_puzzle_finalizado():
	print("🎉 Puzzle finalizado")

	if chave_pendente != "":
		var player = get_tree().get_first_node_in_group("player")
		player.collect_key(chave_pendente)
		chave_pendente = ""

	dialogo_resultado.start_certo()
	puzzle_aberto = false


# =========================
# FINAL
# =========================

func _on_dialogo_finalizado():
	print("✅ Fluxo encerrado")


func _on_player_entrou_estatua():
	print("📜 Player pode interagir com a estátua")
	quest_1.visible = true


func _on_player_saiu_estatua():
	print("❌ Player saiu da estátua")
	quest_1.visible = false
