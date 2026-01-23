extends StaticBody2D

@onready var dialog_box: Control = $Dialogo_3/DialogBox_3

func interact():
	print("INTERACT NA ESTÁTUA")
	dialog_box.next()
