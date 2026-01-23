extends Control

signal dialogo_finalizado

@onready var dialogo_certo := $Dialogo_1_Certo
@onready var dialogo_errado := $Dialogo_2_Errado
var is_open := false


func _ready():
	visible = false
	_esconder_todos()


func _esconder_todos():
	if dialogo_certo:
		dialogo_certo.visible = false
	if dialogo_errado:
		dialogo_errado.visible = false


func start_certo():
	_esconder_todos()
	visible = true
	dialogo_certo.visible = true
	is_open = true

	# Centralizar
	dialogo_certo.anchor_left = 0.5
	dialogo_certo.anchor_top = 0.5
	dialogo_certo.anchor_right = 0.5
	dialogo_certo.anchor_bottom = 0.5
	dialogo_certo.position = -dialogo_certo.size / 2

func start_errado():
	_esconder_todos()
	visible = true
	dialogo_errado.visible = true
	is_open = true

func close():
	visible = false
	_esconder_todos()
	is_open = false
	emit_signal("dialogo_finalizado")
	
	
func _unhandled_input(event):
	if is_open and event.is_action_pressed("ui_accept"):
		close()
