extends Node2D

@export var projectile_shooter: ProjectileShooter
@export var bullet_speed: int = 100
@export var bullet_damage: int = 1
@export var bullet_creation_point: Node2D
@export_flags_2d_physics var projectile_scanned_layer: int

func _ready() -> void:
	projectile_shooter.projectile_scanned_layer = projectile_scanned_layer

func _process(_delta: float) -> void:
	_rotate_to_face_mouse()
	if Input.is_action_just_pressed("shoot"):
		_shoot()

func _rotate_to_face_mouse() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var rotation_to_mouse: float = global_position.angle_to_point(mouse_position)
	
	rotation = rotation_to_mouse

func _shoot() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var direction_to_mouse: Vector2 = bullet_creation_point.global_position.direction_to(mouse_position)
	projectile_shooter.shoot(bullet_creation_point.global_position, direction_to_mouse, bullet_speed, bullet_damage)
