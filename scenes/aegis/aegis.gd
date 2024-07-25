extends Area2D

@export var animation_player: AnimationPlayer
@export var stun_duration: float = 5

func _ready() -> void:
	_play_animations()

func _play_animations() -> void:
	animation_player.play("default")

# Call through animation
func trigger_effect() -> void:
	_destroy_bullets()
	_stun_enemies()

func _destroy_bullets() -> void:
	for area: Area2D in get_overlapping_areas():
		var bullet: Projectile = area as Projectile
		if bullet != null:
			bullet._destroy()
			
func _stun_enemies() -> void:
	for body: PhysicsBody2D in get_overlapping_bodies():
		var enemy: Enemy = body as Enemy
		if enemy != null:
			enemy.stun(stun_duration)
