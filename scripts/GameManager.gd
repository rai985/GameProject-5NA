# Gerenciador das fases do jogo =) 

extends Node2D

@export var skeleton_scene: PackedScene
@export var boss_orc_scene: PackedScene

var spawn_positions: Array = [
	Vector2(13, 15),
	Vector2(1054, 590),
	Vector2(1061, 389),
	Vector2(86, 548),
	Vector2(200, 200),
	Vector2(800, 100),
	Vector2(100, 400),
	Vector2(900, 500)
]

func _ready():
	Global.all_skeletons_dead.connect(on_all_skeletons_dead)
	Global.skeleton_died.connect(on_skeleton_died)
	
	# Inicia os esqueletos existentes na cena
	var initial_skeletons = get_tree().get_nodes_in_group("Skeleton")
	Global.skeletons_alive = initial_skeletons.size()
	
	# Se não houver esqueletos iniciais, spawna alguns
	if Global.skeletons_alive == 0:
		spawn_skeletons()

func spawn_skeletons():
	var available_spawn_positions = spawn_positions.duplicate()
	available_spawn_positions.shuffle()
	for i in range(Global.max_skeletons):
		if available_spawn_positions.is_empty():
			print("Não há posições de spawn suficientes para todos os esqueletos.")
			break
		var skeleton = skeleton_scene.instantiate()
		var chosen_pos = available_spawn_positions.pop_front()
		skeleton.position = chosen_pos
		add_child(skeleton)
		Global.skeletons_alive += 1
		skeleton.add_to_group("Skeleton")
# Gerencia a quantidade de esqueletos na primeira fase e spawna o Boss
func on_all_skeletons_dead():
	if Global.skeletons_killed_total >= 25 and not Global.boss_orc_spawned:
		spawn_boss_orc()
		Global.boss_orc_spawned = true
	else:
		spawn_skeletons()

func spawn_boss_orc():
	print("Boss Orc will spawn!")
	var boss_orc = boss_orc_scene.instantiate()
	var random_pos = spawn_positions[randi() % spawn_positions.size()]
	boss_orc.position = random_pos
	add_child(boss_orc)
	# Para o loop de respawn dos esqueletos
	Global.max_skeletons = 0

func on_skeleton_died():
	print("Esqueletos mortos: ", Global.skeletons_killed_total)
