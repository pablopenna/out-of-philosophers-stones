class_name Obus extends Projectile

@export var sprite2D: Sprite2D
@export var explosion_scene: PackedScene

func _ready() -> void:
	super._ready()
	sprite2D.look_at(global_position + direction)

func _on_hurtbox_entered(hurtbox: Hurtbox) -> void:
	_instantiate_explosion()
	call_deferred("queue_free")

func _on_visible_on_screen_notifier_2d_screen_exited():
	super._on_visible_on_screen_notifier_2d_screen_exited()

func _instantiate_explosion() -> void:
	var explosion: Explosion = explosion_scene.instantiate() as Explosion
	explosion.damage = self.damage
	explosion.global_position = global_position
	explosion.collision_layer = collision_layer
	explosion.collision_mask = collision_mask
	AddToTreeUtils.add_mix_to_tree(explosion)
