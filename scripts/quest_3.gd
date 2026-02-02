extends CanvasLayer

signal resposta_escolhida(correta: bool)

@onready var btn_1 := $Quest_3/Amarela
@onready var btn_2 := $Quest_3/Azul
@onready var btn_3 := $Quest_3/Verde

func _ready():
	visible = true

	btn_1.pressed.connect(func(): _responder(false))   # correta
	btn_2.pressed.connect(func(): _responder(false))
	btn_3.pressed.connect(func(): _responder(true))

func abrir():
	visible = true


func fechar():
	visible = false


func _responder(correta: bool):
	print("Resposta:", correta)
	emit_signal("resposta_escolhida", correta)
	fechar()
