extends Node2D

var bullet_initial_speed: int = 750
var bullet_acceleration: int = 750
var bullet_damage: int = 100
var shots_before_destroy: int = 1
var times_shot: int
var bullets_shot: Array[Projectile]

@export var projectile_shooter: ProjectileShooter
@export var sprite: Sprite2D
@export var bullet_creation_point: Node2D
@export_flags_2d_physics var projectile_scanned_layer: int
@export_flags_2d_physics var projectile_layer: int

func _ready() -> void:
	projectile_shooter.projectile_scanned_layer = projectile_scanned_layer
	projectile_shooter.projectile_layer = projectile_layer
	times_shot = 0
	bullets_shot = []

func _process(delta: float) -> void:
	_rotate_to_face_mouse()
	_update_bullets_speed(delta)
	_process_shot()

func _rotate_to_face_mouse() -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var rotation_to_mouse: float = global_position.angle_to_point(mouse_position)
	rotation = rotation_to_mouse
	if abs(rotation_degrees) > 90:
		sprite.flip_v = true
	else:
		sprite.flip_v = false

func _update_bullets_speed(delta: float) -> void:
	for bullet: Projectile in bullets_shot:
		if bullet != null:
			bullet.speed += bullet_acceleration * delta

func _process_shot() -> void:
	if Input.is_action_just_pressed("shoot") and _can_shoot():
		var bullet: Projectile = _shoot()
		bullets_shot.append(bullet) # TODO: remove projectiles that are deleted from list
		times_shot += 1
		bullet.tree_exiting.connect(_process_destroy)

func _shoot() -> Projectile:
	var mouse_position: Vector2 = get_global_mouse_position()
	var direction_to_mouse: Vector2 = global_position.direction_to(mouse_position)
	var bullet: Projectile = projectile_shooter.shoot(bullet_creation_point.global_position, direction_to_mouse, bullet_initial_speed, bullet_damage)
	return bullet

func _process_destroy() -> void:
	if not _can_shoot():
		call_deferred("queue_free")
		
func _can_shoot() -> bool:
	return times_shot < shots_before_destroy
