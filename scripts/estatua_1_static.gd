extends StaticBody2D

@onready var dialog_box: Control = $Dialogo_1/DialogBox

func interact(_player = null):
	print("INTERACT FOI CHAMADO")
	dialog_box.next()
