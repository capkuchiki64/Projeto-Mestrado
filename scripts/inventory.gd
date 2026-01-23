extends Node

signal inventory_changed

# Quatro chaves
var keys := {
	"red": false,
	"blue": false,
	"green": false,
	"yellow": false
}

func add_key(color: String):
	if keys.has(color):
		keys[color] = true
		inventory_changed.emit()

func has_key(color: String) -> bool:
	return keys.get(color, false)

func remove_key(color: String):
	if has_key(color):
		keys[color] = false
		inventory_changed.emit()
