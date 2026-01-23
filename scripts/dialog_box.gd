extends Control

signal dialogo_puzzle_chamado

@onready var dialogos: Array = get_children()
var dialog_index := 0
var is_open := false

func _ready():
	visible = false
	_esconder_todos()

func _esconder_todos():
	for d in dialogos:
		if d is Control:
			d.visible = false

# =========================
# DIÁLOGO INICIAL (ESTÁTUA)
# =========================
func start():
	print("📦 DialogBox start() chamado")
	dialog_index = 0
	is_open = true
	visible = true
	_esconder_todos()
	_mostrar_atual()

func _mostrar_atual():
	if dialog_index < dialogos.size():
		dialogos[dialog_index].visible = true
	else:
		close()

func next():
	if not is_open:
		return

	dialog_index += 1
	_esconder_todos()
	_mostrar_atual()

func close():
	_esconder_todos()
	visible = false
	is_open = false
	emit_signal("dialogo_puzzle_chamado")

# =========================
# INPUT
# =========================
func _input(event):
	if event.is_action_pressed("ui_accept") and is_open:
		next()
