extends Node2D

@onready var textura: Sprite2D = $Textura
@onready var detecçao: Area2D = $Detecçao

const lines : Array[String] = [
	"Aqui estão os ex-presidentes que governaram o Brasil entre 1889 a 1960...",
	"Inclusive eu...",
	"Fique à vontade para explorar e conhecer sobre cada um deles.",
	"Inclusive eu...",
	"Agora, se quiser avançar, a chave para o segundo portal também está com eles.",
	"Fica no Palácio do Catete", 
	"Para te ajudar a saber qual a chave correta, responda ao enigma:",
	"Sou aquilo que te move quando o despertador toca e você pensa:", 
	"AAFFFFF!!!!!",
	"Queria dormir mas...",
	"A vida não é só flores...",
	"Ou morangos...",
	"Sou o que faz alguém vender docinho na escola",
	"Querer abrir a própria loja",
	"Ou criar uma conta no Instagram...",
	"(Sou uma cabeça apenas e estou mais atualizado que um pessoal a)",
	"Ninguém de fora mete o bedelho — quem manda ali é sua família.",
	"Agora pensa isso em versão país:",
	"eu sou o direito de decidir tudo sem depender de ninguém.",
	"Leis? A gente faz.",
	"Economia? A gente escolhe.", 
	"Cultura? A gente vive do nosso jeito." ,
	"Se outro país tentar mandar em mim… pode parar!", 
	"Porque eu sou tipo a independência com orgulho." ,
	"Quem sou eu?"
	]

func _unhandled_input(event):
	if detecçao.get_overlapping_bodies().size() > 0:
		textura.show()
		if event.is_action_pressed("interacao") && !DialogManager.is_message_active:
			textura.hide()
			DialogManager.start_message(global_position, lines)
	else:
		textura.hide()
		if DialogManager.dialog_box != null:
			DialogManager.dialog_box.queue_free()
			DialogManager.is_message_active = false
