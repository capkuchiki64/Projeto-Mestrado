extends StaticBody2D

@onready var dialog_box: Control = $Dialogo_3/DialogBox_3

func interact(_player = null):
	print("INTERACT FOI CHAMADO")
	dialog_box.next()
