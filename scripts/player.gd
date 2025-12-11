extends CharacterBody2D

var input_vector: Vector2 = Vector2.ZERO
var current_speed: float = 300.0

@onready var _sprite: AnimatedSprite2D = $AnimatedSprite2D

var can_interact: bool = false
var interact_target: Node = null


func _ready():
	pass


func _process(delta):
	handle_movement(delta)


func handle_movement(delta):
	input_vector = Vector2.ZERO  # reset do vetor a cada frame

	if Input.is_action_pressed("direita"):
		input_vector.x = 1
		_sprite.play("walk_right")

	elif Input.is_action_pressed("esquerda"):
		input_vector.x = -1
		_sprite.play("walk_left")

	elif Input.is_action_pressed("cima"):
		input_vector.y = -1
		_sprite.play("walk_up")

	elif Input.is_action_pressed("baixo"):
		input_vector.y = 1
		_sprite.play("walk_down")

	else:
		_sprite.play("idle")

	# movimento
	velocity = input_vector.normalized() * current_speed
	move_and_slide()


func _input(event):
	if event.is_action_pressed("interacao") and can_interact and interact_target:
		interact_target.interact()
