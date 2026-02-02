extends StaticBody2D

signal pedir_escolha_chave

signal segundo_andar_liberado

signal estatua_interagida(puzzle_scene: PackedScene, key_color: String)

@export var puzzle_scene: PackedScene
@export var key_color: String = "green"

@onready var dialog_box: Control = $Dialogo_Patria/DialogBox_5
@onready var area: Area2D = $Area2D

var player_na_area := false

func _ready():
	area.player_entrou.connect(_on_player_entrou)
	area.player_saiu.connect(_on_player_saiu)

func _on_player_entrou(player):
	player_na_area = true
	dialog_box.start()
	player.set_interaction_target(self)

func _on_player_saiu(player):
	player_na_area = false
	player.clear_interaction_target(self)

func _on_dialogo_finalizado():
	emit_signal("segundo_andar_liberado")
	var level = get_tree().current_scene

	if level.chave_conquistada:
		emit_signal("pedir_escolha_chave")

func interact(player):
	if not player_na_area:
		return

	emit_signal("estatua_interagida", puzzle_scene, key_color)

func puzzle_resolvido(player):
	player.collect_key(key_color)
	$Area2D.monitoring = false
	set_process(false)
