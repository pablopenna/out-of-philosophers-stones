extends Area2D

@export var animation_player: AnimationPlayer

func _ready() -> void:
	_play_animations()

func _play_animations() -> void:
	animation_player.play("default")

# Call through animation
func _destroy_bullets() -> void:
	print(get_overlapping_areas())
	for area: Area2D in get_overlapping_areas():
		var bullet: Projectile = area as Projectile
		if bullet != null:
			bullet._destroy()
