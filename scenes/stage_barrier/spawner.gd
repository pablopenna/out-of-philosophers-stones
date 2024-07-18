extends Node

@export var enemyScene: PackedScene
@export var spawnLocation: PathFollow2D
@export var spawnTimer: Timer

func _ready() -> void:
	spawnTimer.timeout.connect(_spawn)

func _spawn() -> void:
	var enemy: Enemy = enemyScene.instantiate()
	
	# Get random location in the path defined by the Path2D which is parent of PathFollow2D
	spawnLocation.progress_ratio = randf()
	enemy.position = spawnLocation.position
	
	
	# Set enemy's direction perpendicular to the path direction.
	var direction: float = spawnLocation.rotation + PI / 2
	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	# enemy.rotation = direction
	
	
	# Choose the velocity for the enemy.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.velocity = velocity.rotated(direction)
	
	add_child(enemy)
