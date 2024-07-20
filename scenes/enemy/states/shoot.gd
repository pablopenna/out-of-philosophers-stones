extends State

@export var pattern_shooter: PatternShooter
@export var timer: Timer
const number_of_projectiles: int = 8

func enter(_context: Dictionary) -> void:
	timer.timeout.connect(_shoot_now)

func exit(_new_state: State) -> void:
	timer.timeout.disconnect(_shoot_now)
	
func _shoot_now() -> void:
	pattern_shooter.shoot_360(number_of_projectiles, Vector2.RIGHT)
