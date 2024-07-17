class_name ProjectileShooter extends Node2D

@export var projectileScene: PackedScene
var projectile_scanned_layer: int
	
func shoot(
	initial_position: Vector2,
	direction: Vector2, 
	speed: float,
	damage: int,
) -> void:
	var projectile: Projectile = projectileScene.instantiate()
	
	# projectile.collision_layer = projectile_layer
	projectile.collision_mask = self.projectile_scanned_layer
	projectile.direction = direction
	projectile.speed = speed
	projectile.global_position = initial_position
	projectile.damage = damage
	
	# TODO: instantiate at the same level as the entity firing this.
	get_tree().get_root().add_child(projectile)
