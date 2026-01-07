extends Node2D

@export var tile_scene: PackedScene
@export var tile_textures: Array[Texture2D]

const GRID_SIZE: int = 3
const TILE_SIZE: int = 128
const GRID_OFFSET: Vector2 = Vector2(-96, -96)

var empty_pos: Vector2i = Vector2i(2, 2)
var tiles: Dictionary = {}
var is_moving: bool = false

# COMBINAÇÃO ESPECÍFICA DE VITÓRIA
var victory_layout := {
	Vector2i(0,0): 1,
	Vector2i(1,0): 2,
	Vector2i(2,0): 3,
	Vector2i(0,1): 4,
	Vector2i(1,1): 5,
	Vector2i(2,1): 6,
	Vector2i(0,2): 7,
	Vector2i(1,2): 8
}

@onready var grid: Node2D = $Grid


func _ready():
	create_grid()
	shuffle(60)


# =========================
# CRIAÇÃO DO GRID
# =========================
func create_grid():
	var id: int = 1

	for y in range(GRID_SIZE):
		for x in range(GRID_SIZE):

			var pos: Vector2i = Vector2i(x, y)
			if pos == empty_pos:
				continue

			var tile = tile_scene.instantiate()
			grid.add_child(tile)

			tile.tile_id = id
			tile.grid_pos = pos
			tile.correct_pos = pos

			# TEXTURA DIFERENTE PARA CADA TILE
			if id - 1 < tile_textures.size():
				tile.set_texture(tile_textures[id - 1])

			tile.position = grid_to_world(pos)

			tile.clicked.connect(_on_tile_clicked)

			tiles[pos] = tile
			id += 1


# =========================
# INPUT
# =========================
func _on_tile_clicked(tile):
	if is_moving:
		return

	if can_move(tile.grid_pos):
		move_tile(tile)


# =========================
# MOVIMENTO
# =========================
func can_move(tile_pos: Vector2i) -> bool:
	var diff: Vector2i = tile_pos - empty_pos
	return abs(diff.x) + abs(diff.y) == 1


func move_tile(tile):
	is_moving = true

	var old_pos: Vector2i = tile.grid_pos
	tiles.erase(old_pos)

	tile.grid_pos = empty_pos
	var target_pos: Vector2 = grid_to_world(empty_pos)

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(tile, "position", target_pos, 0.03)

	empty_pos = old_pos
	tiles[tile.grid_pos] = tile

	tween.finished.connect(func():
		is_moving = false
		check_win()
	)


# =========================
# MOVIMENTO INSTANTÂNEO (SHUFFLE)
# =========================
func move_tile_instant(tile):
	var old_pos: Vector2i = tile.grid_pos
	tiles.erase(old_pos)

	tile.grid_pos = empty_pos
	tile.position = grid_to_world(empty_pos)

	empty_pos = old_pos
	tiles[tile.grid_pos] = tile


# =========================
# GRID → MUNDO
# =========================
func grid_to_world(pos: Vector2i) -> Vector2:
	return Vector2(
		pos.x * TILE_SIZE,
		pos.y * TILE_SIZE
	)


# =========================
# EMBARALHAR (SEMPRE SOLVÁVEL)
# =========================
func shuffle(moves: int):
	for i in range(moves):
		var neighbors: Array = []

		for dir in [
			Vector2i.UP,
			Vector2i.DOWN,
			Vector2i.LEFT,
			Vector2i.RIGHT
		]:
			var pos: Vector2i = empty_pos + dir
			if tiles.has(pos):
				neighbors.append(tiles[pos])

		if neighbors.size() > 0:
			move_tile_instant(neighbors.pick_random())


# =========================
# CONDIÇÃO DE VITÓRIA
# =========================
func check_win():
	for pos in victory_layout.keys():
		if not tiles.has(pos):
			return

		var tile = tiles[pos]
		if tile.tile_id != victory_layout[pos]:
			return

	print("🎉 Combinação correta!")
