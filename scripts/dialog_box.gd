extends Control

signal dialogo_finalizado
signal dialogo_puzzle_chamado

@onready var dialogos := get_children()

var dialog_index: int = 0
var is_open: bool = false

@export var chama_puzzle: bool = false

func _ready():
	visible = false
	hide_all()

func hide_all():
	for d in dialogos:
		if d is Control:
			d.visible = false

func start():
	dialog_index = 0
	is_open = true
	visible = true
	hide_all()
	_show_current()

func start_from(index: int):
	dialog_index = index
	is_open = true
	visible = true
	hide_all()
	_show_current()

func _show_current():
	if dialog_index < dialogos.size():
		dialogos[dialog_index].visible = true
	else:
		close()

func next():
	if not is_open:
		start()
	else:
		dialog_index += 1
		hide_all()
		_show_current()

func close():
	hide_all()
	is_open = false
	visible = false
	
	if chama_puzzle:
		emit_signal("dialogo_puzzle_chamado")
	else:
		emit_signal("dialogo_finalizado")

func _input(event):
	if event.is_action_pressed("ui_accept") and is_open:
		next()
