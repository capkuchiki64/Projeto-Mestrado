extends Node2D

@onready var textura: Sprite2D = $Textura
@onready var detecçao: Area2D = $Detecçao

const lines : Array[String] = [
	"Bem vindo ao Guardiões da República!",
	"Este jogo é uma exigência do mestrado ProfEPT",
	"Nosso objetivo é que ao final desta jornada,",
	"Você possa conhecer sobre seus direitos e deveres.",
	"Você está no Museu da República,",
	"Fica no Palácio do Catete", 
	"Residência dos Presidentes da República,",
	"Entre os anos de 1889 a 1960...", 
	"Quando o Rio de Janeiro era a capital do Brasil.",
	"Te convidamos a conhecer,",
	"Esse palácio que protege a nossa memória...",
	"Você deve estar se perguntando sobre essa porta.",
	"Bom, para avançar,",
	"Você precisa procurar a chave que a abra!",
	"Para descobrir a chave correta, responda ao seguinte:",
	"Imagina que sua casa tem regras próprias.",
	"Você pode escolher a comida, o estilo, a TV.",
	"Ninguém de fora mete o bedelho — quem manda ali é você.",
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
