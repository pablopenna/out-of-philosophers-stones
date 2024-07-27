extends Sprite2D

@export var enemy: Enemy

func _physics_process(delta):
	if enemy.velocity.x < 0:
		flip_h = true
	elif enemy.velocity.x > 0:
		flip_h = false
