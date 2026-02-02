extends StaticBody2D

signal pedir_escolha_chave

@onready var dialog_box: Control = $Dialogo_3/DialogBox_3
@onready var area: Area2D = $Area2D

var player_na_area := false

func _ready():
	area.player_entrou.connect(_on_player_entrou)
	area.player_saiu.connect(_on_player_saiu)

func _on_player_entrou():
	player_na_area = true
	dialog_box.start()

func _on_player_saiu():
	player_na_area = false

func _on_dialogo_finalizado():
	var level = get_tree().current_scene

	if level.chave_conquistada:
		emit_signal("pedir_escolha_chave")
