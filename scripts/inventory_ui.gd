extends Control

@onready var player = get_tree().get_first_node_in_group("player")
@onready var inventory = player.get_node("Inventory")

@onready var key_icons := {
	"yellow": $chave_amarela,
	"blue": $chave_azul,
	"green": $chave_verde,
	"red": $chave_colorida

}

func _ready():
	# GARANTE invisível no código também
	for icon in key_icons.values():
		icon.visible = false

	# Conecta DEPOIS de esconder
	inventory.inventory_changed.connect(update_ui)

func update_ui():
	for color in key_icons.keys():
		key_icons[color].visible = inventory.has_key(color)
