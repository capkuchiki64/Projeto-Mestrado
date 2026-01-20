extends Button

@export var alvo_interacao: NodePath
var _alvo: Node = null

func _ready():
	# Pega o alvo definido no Inspetor
	if alvo_interacao != NodePath():
		_alvo = get_node_or_null(alvo_interacao)
	
	# Fallback: se não achou (ou esquecer de setar), tenta achar por nome ou grupo
	if not _alvo:
		_alvo = get_tree().get_root().find_child("Player", true, false)
	if not _alvo:
		var candidates = get_tree().get_nodes_in_group("player")
		if candidates.size() > 0:
			_alvo = candidates[0]

	pressed.connect(_on_pressed)
	print("[Botao] _ready alvo_interacao =", alvo_interacao, " alvo =", _alvo)

func _on_pressed():
	print("[Botao] pressed. alvo =", _alvo)
	if _alvo and _alvo.has_method("executar_interacao"):
		_alvo.executar_interacao()
	else:
		print("[Botao] ERRO: alvo nulo ou sem método executar_interacao()")
