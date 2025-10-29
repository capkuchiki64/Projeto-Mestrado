extends CharacterBody2D

@export var speed: float = 500.0

var target_position: Vector2
var moving: bool = false
var pressed = false
var keys: Dictionary = {}

# Área de interação para detectar portas próximas (opcional)
@onready var interact_area: Area2D = get_node_or_null("InteractArea")

func _ready():
#	$Interacao.connect("pressed", self, "_on_interact_button_pressed")
	target_position = global_position
	var _on_interact_button_pressed = false


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		target_position = get_global_mouse_position()
		moving = true
	if Input.is_action_just_pressed("interacao"):
		executar_interacao()
	if event.is_action_pressed("interacao"):
		if interact_area:
			for body in interact_area.get_overlapping_bodies():
				if body.has_method("try_open"):
					body.try_open(self)
					return


func _physics_process(delta):
	var walking = $Walking as AudioStreamPlayer2D
	
	if moving:
		var to_target = target_position - global_position
		var distance = to_target.length()
		var step = speed * delta
		# Inventário: tipo_de_chave -> quantidade
		


		if distance > step:
			velocity = to_target.normalized() * speed
			move_and_slide()
		else:
			global_position = target_position
			velocity = Vector2.ZERO
			moving = false
	else:
		velocity = Vector2.ZERO
		walking.play()
		
func executar_interacao():
	# Toda a lógica de interação (abrir diálogo, pegar item, etc.)
	print("Interagir!")
#func interagir_com_estatua():
	# Lógica de interação, como detectar estátuas próximas e interagir
#	print("Interagindo com estátua!")
func add_key(t: int, amount: int = 1) -> void:
	keys[t] = keys.get(t, 0) + amount
func has_key(t: int) -> bool:
	return keys.get(t, 0) > 0

func remove_key(t: int, amount: int = 1) -> void:
	if has_key(t):
		keys[t] = max(0, int(keys[t]) - amount)

func get_owned_keys() -> Array[int]:
	var out: Array[int] = []
	for t in keys.keys():
		if keys[t] > 0:
			out.append(t)
	return out
	
# Interagir com a porta focada/mais próxima
