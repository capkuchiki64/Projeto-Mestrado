extends Control

var dialog_index := 0
var dialog_nodes := []


func _ready():
	dialog_nodes = [
	]

	reset_dialog()


func reset_dialog():
	dialog_index = 0

	# Esconde todos
	for d in dialog_nodes:
		if d != null:
			d.hide()

	# Mostra o primeiro
	if dialog_nodes.size() > 0:
		dialog_nodes[0].show()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_next_dialog()


func _next_dialog():
	# Proteção: impedir estouro de índice
	if dialog_index >= dialog_nodes.size():
		hide()
		return

	# Esconde o atual
	dialog_nodes[dialog_index].hide()

	dialog_index += 1

	# Se ainda existe diálogo seguinte
	if dialog_index < dialog_nodes.size():
		dialog_nodes[dialog_index].show()
	else:
		print("Fim dos diálogos!")
		hide()
