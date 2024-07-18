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
	var gun_root: Node = get_parent()
	var gun_parent: Node = gun_root.get_parent()
	var parent_of_gun_parent: Node = gun_parent.get_parent()
	parent_of_gun_parent.add_child(projectile)
