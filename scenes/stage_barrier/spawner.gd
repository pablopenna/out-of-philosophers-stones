extends Node

@export var enemyScene: PackedScene
@export var spawnLocation: PathFollow2D
@export var spawnTimer: Timer

func _ready() -> void:
	spawnTimer.timeout.connect(_spawn)

func _spawn() -> void:
	var enemy: Enemy = enemyScene.instantiate() as Enemy
	
	# Get random location in the path defined by the Path2D which is parent of PathFollow2D
	spawnLocation.progress_ratio = randf()
	enemy.position = spawnLocation.position
	
	# Set enemy's direction perpendicular to the path direction.
	var direction: float = spawnLocation.rotation + PI / 2
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	enemy.direction = Vector2.RIGHT.rotated(direction)
	
	# Choose the velocity for the enemy.
	var speed: int = randi_range(150, 250)
	enemy.move_speed = speed
	
	add_child(enemy)
