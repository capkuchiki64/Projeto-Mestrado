extends Node

signal message_finished            # Emite quando todo o diálogo termina (todas as linhas foram avançadas)
signal last_line_displayed         # Emite quando a ÚLTIMA linha termina de ser exibida (efeito de digitação concluído)

@onready var caixa_de_dialogo = preload("res://caixa_de_dialogo.tscn")
var message_lines : Array[String] = []
var current_line : int = 0

var dialog_box
var dialog_box_position := Vector2.ZERO

var is_message_active := false 
var can_advance_message := false

# Fica true quando a ÚLTIMA linha terminou de ser exibida (acabou_o_texto da última linha).
var fala_terminou: bool = false

func start_message(position: Vector2, lines: Array[String]) -> void:
	if is_message_active:
		return
	message_lines = lines
	dialog_box_position = position
	fala_terminou = false
	current_line = 0
	show_text()
	is_message_active = true
	
func show_text() -> void:
	dialog_box = caixa_de_dialogo.instantiate()
	dialog_box.acabou_o_texto.connect(_on_all_text_displayed)
	get_tree().root.add_child(dialog_box)
	dialog_box.global_position = dialog_box_position
	dialog_box.display_text(message_lines[current_line])
	can_advance_message = false
	
func _on_all_text_displayed() -> void:
	can_advance_message = true
	# Se a linha atual é a última, marca e emite o sinal.
	if current_line == message_lines.size() - 1:
		fala_terminou = true
		last_line_displayed.emit()
	
func _unhandled_input(event) -> void:
	if event.is_action_pressed("avançar_mensagem") and is_message_active and can_advance_message:
		dialog_box.queue_free()
		current_line += 1
		if current_line >= message_lines.size():
			# Diálogo terminou
			is_message_active = false
			can_advance_message = false
			message_lines = []
			message_finished.emit()
			current_line = 0
			return
		show_text()
