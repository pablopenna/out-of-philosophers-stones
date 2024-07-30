class_name Boss extends CharacterBody2D

@export var target: Node2D # to be set by the instantiator
@export var move_speed: int = 100
var direction: Vector2
@export var shoot_cooldown_in_ms: int = 100
var last_shot_timestamp_in_ms: int = 0
var current_shooting_pattern: int = 0

@export var hp_manager: HealthPointsManager
@export var ingredient_factory: IngredientFactory
@export var change_shoot_pattern_timer: Timer
@export var projectile_shooter: ProjectileShooter
@export var sound_player: AudioStreamPlayer

signal died

func _ready() -> void:
	sound_player.play()
	GlobalEvents.shake_screen.emit(300)
	hp_manager.health_zeroed.connect(_on_died)
	change_shoot_pattern_timer.timeout.connect(_change_shoot_pattern)
	direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()
	velocity = direction * move_speed

func _on_died() -> void:
	for i: int in range(10):
		ingredient_factory.create_random_ingredient(true)
	
	died.emit()
	GlobalEvents.boss_killed.emit()
	
	queue_free()


func _physics_process(delta: float) -> void:
	_move_and_bounce_on_walls(delta)
	_process_shoot()

func _move_and_bounce_on_walls(delta: float) -> void:
	# https://docs.godotengine.org/en/stable/tutorials/math/vector_math.html
	var collision: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision:
		var reflect: Vector2 = collision.get_remainder().bounce(collision.get_normal())
		velocity = velocity.bounce(collision.get_normal())
		move_and_collide(reflect)

func _process_shoot() -> void:
	if Time.get_ticks_msec() > last_shot_timestamp_in_ms + shoot_cooldown_in_ms:
		_shoot_current_pattern()
		last_shot_timestamp_in_ms = Time.get_ticks_msec()

func _shoot_current_pattern() -> void:
	match current_shooting_pattern:
		0: 
			_shoot_360(25)
		1:
			_shoot_empty_cone(global_position.direction_to(target.global_position))
		2:
			_shoot_filled_cone(global_position.direction_to(target.global_position))
		3: 
			_shoot_spray(global_position.direction_to(target.global_position))
		_:
			_shoot_360(25)

func _change_shoot_pattern() -> void:
	current_shooting_pattern = randi_range(0,3)

# TODO: all shooting patters should be in Projectile shooter
# TODO: duplicate code in shooting_pattern.gd
#region shooting_patterns
func _shoot_360(number_of_projectiles: int) -> void:
	const FULL_TURN: float = 2*PI
	var direction_offset: float = FULL_TURN / number_of_projectiles
	var speed: int = 100
	var damage: int = 1
	
	for n: int in number_of_projectiles:
		var shoot_direction: Vector2 = Vector2.RIGHT.rotated(direction_offset * n)
		projectile_shooter.shoot(
			global_position,
			shoot_direction,
			speed,
			damage
		)

func _shoot_empty_cone(target_direction: Vector2) -> void:
	var cone_angle: float = PI / 8
	var speed: int = 100
	var damage: int = 1
	
	projectile_shooter.shoot(
		global_position,
		target_direction.rotated(cone_angle),
		speed,
		damage
	)
	
	projectile_shooter.shoot(
		global_position,
		target_direction.rotated(cone_angle * -1.0),
		speed,
		damage
	)
	
func _shoot_filled_cone(target_direction: Vector2) -> void:
	var number_of_bullets_in_cone: int = 5
	var cone_angle: float = PI / 8
	var speed: int = 100
	var damage: int = 1
	
	for i: int in range(1, number_of_bullets_in_cone+1):
		var current_bullet_angle: float = (cone_angle / number_of_bullets_in_cone) * i
	
		projectile_shooter.shoot(
			global_position,
			target_direction.rotated(-cone_angle/2).rotated(current_bullet_angle), # We want the mid bullet to go straight to the target
			speed,
			damage
		)

func _shoot_spray(target_direction: Vector2) -> void:
	var max_offset_angle: float = PI / 8
	var speed: int = 100
	var damage: int = 1
	
	projectile_shooter.shoot(
		global_position,
		target_direction.rotated(max_offset_angle * sin(Time.get_ticks_msec())),
		speed,
		damage
	)

#endregion
