class_name ProjectileShooter extends Node2D

@export var projectileScene: PackedScene
@export_flags_2d_physics var projectile_scanned_layer: int
@export_flags_2d_physics var projectile_layer: int
	
func shoot(
	initial_position: Vector2,
	direction: Vector2, 
	speed: float,
	damage: int,
) -> void:
	var projectile: Projectile = projectileScene.instantiate()
	
	projectile.collision_layer = self.projectile_layer
	projectile.collision_mask = self.projectile_scanned_layer
	projectile.direction = direction
	projectile.speed = speed
	projectile.global_position = initial_position
	projectile.damage = damage
	
	var projectileContainer: Node = get_tree().get_first_node_in_group("ProjectileContainer")
	if projectileContainer != null:
		projectileContainer.add_child(projectile)
	else:
		get_tree().root.add_child(projectile)
