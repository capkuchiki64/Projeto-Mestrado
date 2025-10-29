extends MarginContainer

@onready var player: CharacterBody2D = $Player
@onready var digitando: Timer = $Digitando
@onready var text_label: Label = $Margem/Texto
@onready var ui_position := $Player/Camera2D/CanvasLayer
const LARGURA_MAX := 50

var text: String = ""
var letter_index: int = 0

var delay_letra := 0.07
var delay_espaco := 0.05
var delay_pontuacao := 0.2

signal acabou_o_texto()

func _ready():
	digitando.one_shot = true
	# Se não tiver conectado via editor:
	# digitando.timeout.connect(_on_digitando_timeout)

func display_text(text_to_display: String):
	digitando.stop()
	text = text_to_display
	letter_index = 0

	text_label.text = text_to_display
	await resized
	custom_minimum_size.x = min(size.x, LARGURA_MAX)

	if size.x > LARGURA_MAX:
		text_label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y

	# Ajustes de posição (se realmente quiser)
	global_position.x -= player.position.x
	global_position.y -= player.position.y + 24

	text_label.text = ""

	if text.is_empty():
		_finalizar()
	else:
		_display_letter()

func _display_letter():
	# 1. Antes de acessar, verifique se ainda há caracteres
	if letter_index >= text.length():
		_finalizar()
		return

	# 2. Adiciona a letra
	text_label.text += text[letter_index]
	letter_index += 1

	# 3. Caso tenha terminado logo após adicionar
	if letter_index >= text.length():
		_finalizar()
		return

	# 4. Decide atraso para a próxima letra (versão if/elif)
	var proximo_char := text[letter_index]
	var delay: float
	if proximo_char == " ":
		delay = delay_espaco
	elif proximo_char == "!" or proximo_char == "?" or proximo_char == "," or proximo_char == ".":
		delay = delay_pontuacao
	else:
		delay = delay_letra

	digitando.start(delay)

func _finalizar():
	digitando.stop()
	acabou_o_texto.emit()

func _on_digitando_timeout():
	_display_letter()

# Permite pular animação e mostrar tudo
func skip():
	if letter_index < text.length():
		text_label.text = text
		letter_index = text.length()
		_finalizar()
