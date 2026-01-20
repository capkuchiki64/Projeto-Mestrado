extends Area2D

@onready var player: CharacterBody2D = $"../Player"
@onready var sprite: Sprite2D = $Escada
@onready var visao_da_escada: CollisionPolygon2D = $"Visao da escada" # (opcional, não é usado diretamente)

var ALPHA_FORA := 0.35
var ALPHA_DENTRO := 1.0
var PLAYER_GROUP := "player"
var DURACAO := 0.25
var tween: Tween

# --- Novos parâmetros para z_index ---
var PLAYER_Z_DENTRO: int = 1          # z enquanto está dentro
var PLAYER_Z_FORA_OVERRIDE: int = -999 # -999 = restaurar original; qualquer outro número força esse valor ao sair

var _player_original_z: int = -999
var _original_z_guardado: bool = false

func _ready():
	body_entered.connect(_on_enter)
	body_exited.connect(_on_exit)
	_forcar_alpha(ALPHA_FORA)

func _on_enter(body):
	if body.is_in_group(PLAYER_GROUP):
		# Guarda z original só na primeira entrada
		if not _original_z_guardado:
			_player_original_z = body.z_index
			_original_z_guardado = true
		# Ajusta z
		body.z_index = PLAYER_Z_DENTRO
		_animar(ALPHA_DENTRO)

func _on_exit(body):
	if body.is_in_group(PLAYER_GROUP):
		await get_tree().process_frame
		if not _player_dentro():
			_animar(ALPHA_FORA)
			# Restaura ou aplica override
			if _original_z_guardado:
				if PLAYER_Z_FORA_OVERRIDE != -999:
					body.z_index = PLAYER_Z_FORA_OVERRIDE
				else:
					body.z_index = _player_original_z
				_original_z_guardado = false

func _player_dentro() -> bool:
	for b in get_overlapping_bodies():
		if b.is_in_group(PLAYER_GROUP):
			return true
	return false

func _animar(a: float):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(sprite, "modulate:a", a, DURACAO)

func _forcar_alpha(a: float):
	var c = sprite.modulate
	c.a = a
	sprite.modulate = c
