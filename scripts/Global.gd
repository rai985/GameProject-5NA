extends Node

# --- Sinais ---
signal score_updated(new_score)
signal all_skeletons_dead
signal skeleton_died

# --- Pontuação (do Projeto 2) ---
var score: int = 0

# --- Gerenciamento de Inimigos (do Projeto 1) ---
var skeletons_alive: int = 0
var skeletons_killed_total: int = 0
var max_skeletons: int = 8
var boss_orc_spawned: bool = false


func _ready():
	skeleton_died.connect(func(): skeletons_killed_total += 1)

func add_score(points: int):
	score += points
	score_updated.emit(score)
	print("Pontuação atual: ", score)

func _process(delta: float) -> void:
	pass
