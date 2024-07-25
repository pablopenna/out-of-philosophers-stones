extends State

@export var animation_player: AnimationPlayer
@export var pattern_shooter: PatternShooter
@export var timer: Timer
const number_of_projectiles: int = 8

func _ready() -> void:
	state_name = "shoot"

func enter(_context: Dictionary) -> void:
	animation_player.play("Enemy/idle")
	timer.timeout.connect(_shoot_now)
	var enemy = (managed_node as Enemy)
	enemy.velocity = enemy.move_speed * enemy.direction

func exit(_new_state: State) -> void:
	timer.timeout.disconnect(_shoot_now)
	
func _shoot_now() -> void:
	pattern_shooter.shoot_360(number_of_projectiles, Vector2.RIGHT)
	
