class_name PatternShooter extends Node2D

@export var projectileShooter: ProjectileShooter
const speed: int = 100
const damage: int = 1
const RADS_360: float = 2*PI

func shoot_360(number_of_projectiles: int, base_direction: Vector2) -> void:
	var direction_offset: float = RADS_360 / number_of_projectiles
	
	for n in number_of_projectiles:
		var direction: Vector2 = base_direction.rotated(direction_offset * n)
		projectileShooter.shoot(
			global_position,
			direction,
			speed,
			damage
		)
