extends Area2D

signal clicked(tile)

@export var tile_id: int = 0
@export var is_empty: bool = false

var grid_pos: Vector2i
var correct_pos: Vector2i

@onready var sprite: Sprite2D = $Sprite2D


func set_texture(texture: Texture2D):
	sprite.texture = texture


func _input_event(_viewport, event, _shape_idx):
	if is_empty:
		return

	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.pressed:
		emit_signal("clicked", self)
