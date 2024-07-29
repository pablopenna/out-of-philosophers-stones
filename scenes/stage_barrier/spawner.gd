extends Node

@export var bossScene: PackedScene
@export var enemyScene: PackedScene
@export var spawnPath: PathFollow2D
@export var spawnTimer: Timer
@export var spawnBossAtScore: int = 500
@export var target: Node2D
@export var bossSpawnPoint: Node2D

var _game_score: int
var _difficulty_params: Dictionary
var _has_boss_been_spawned: bool
var _is_boss_dead: bool

func _ready() -> void:
	spawnTimer.timeout.connect(_spawn)
	GlobalEvents.score_updated.connect(_update_score)
	_has_boss_been_spawned = false
	_is_boss_dead = false

func _spawn() -> void:
	if _can_spawn_boss():
		_spawn_boss()
	if _has_boss_been_spawned and not _is_boss_dead:
		return
	_spawn_regular_enemy()

func _spawn_regular_enemy() -> void:
	var enemy: Enemy = enemyScene.instantiate() as Enemy
	enemy.position = _get_random_spawn_position()
	enemy.direction = _get_random_enemy_direction()
	enemy.move_speed = _get_enemy_speed()
	enemy.bullets_shot = _get_enemy_bullets_shot()
	enemy.shoot_cooldown = _get_enemy_shoot_cooldown()
	add_child(enemy)

func _spawn_boss() -> void:
	var boss: Boss = bossScene.instantiate() as Boss
	boss.target = target
	boss.global_position = bossSpawnPoint.global_position
	boss.died.connect(_on_boss_dead)
	_has_boss_been_spawned = true
	add_child(boss)
	
func _can_spawn_boss() -> bool:
	return not _has_boss_been_spawned and _game_score >= spawnBossAtScore

func _on_boss_dead() -> void:
	_is_boss_dead = true

func _get_random_spawn_position() -> Vector2:
	# Get random location in the path defined by the Path2D which is parent of PathFollow2D
	spawnPath.progress_ratio = randf()
	return spawnPath.position

func _get_random_enemy_direction() -> Vector2:
	# Set enemy's direction perpendicular to the path direction.
	var direction: float = spawnPath.rotation + PI / 2
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	return Vector2.RIGHT.rotated(direction)

func _get_enemy_speed() -> int:
	var speed_range: Array = _difficulty_params[DifficultyManager.Parameter.ENEMY_VELOCITY_RANGE]
	var speed: int = randi_range(speed_range[0], speed_range[1])
	return speed
	
func _get_enemy_bullets_shot() -> int:
	return _difficulty_params[DifficultyManager.Parameter.ENEMY_BULLETS_SHOT]

func _get_enemy_shoot_cooldown() -> float:
	return _difficulty_params[DifficultyManager.Parameter.ENEMY_SHOOT_COOLDOWN]

func _get_enemy_spawn_cooldown() -> float:
	return _difficulty_params[DifficultyManager.Parameter.ENEMY_SPAWN_COOLDOWN]

func _update_score(new_score: int) -> void:
	_game_score = new_score
	_difficulty_params = DifficultyManager._get_difficulty_params(new_score)
	
	spawnTimer.wait_time = _get_enemy_spawn_cooldown()
