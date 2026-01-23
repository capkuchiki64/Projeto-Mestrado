extends Control

@onready var dialogos := get_children()
var dialog_index := 0
var is_open := false

func _ready():
	visible = false
	hide_all()

func hide_all():
	for d in dialogos:
		if d is Control:
			d.visible = false

func start():
	dialog_index = 0
	is_open = true
	visible = true
	hide_all()
	_show_current()

func _show_current():
	if dialog_index < dialogos.size():
		dialogos[dialog_index].visible = true
	else:
		close()

func next():
	if not is_open:
		start()
	else:
		dialog_index += 1
		hide_all()
		_show_current()

func close():
	hide_all()
	is_open = false
	visible = false
