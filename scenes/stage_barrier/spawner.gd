extends Node

@export var enemyScene: PackedScene
@export var spawnPath: PathFollow2D
@export var spawnTimer: Timer

var _game_score: int
var _difficulty_params: Dictionary

func _ready() -> void:
	spawnTimer.timeout.connect(_spawn)
	GlobalEvents.score_updated.connect(_update_score)

func _spawn() -> void:
	var enemy: Enemy = enemyScene.instantiate() as Enemy
	
	enemy.position = _get_random_spawn_position()
	enemy.direction = _get_random_enemy_direction()
	enemy.move_speed = _get_enemy_speed()
	enemy.bullets_shot = _get_enemy_bullets_shot()
	enemy.shoot_cooldown = _get_enemy_shoot_cooldown()
	
	add_child(enemy)
	
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
