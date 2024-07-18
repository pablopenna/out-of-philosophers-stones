# The Hurtbox will not scan, it will be passive. The hitbox is in charge of 
# detecting and triggering the hurtbox when they collision	

class_name Hurtbox extends Area2D

signal damaged(hitboxData: HitboxData)

func receiveDamage(hitboxData: HitboxData) -> void:
	emit_signal("damaged", hitboxData)
		
static func get_hurtbox_from_collider(collider: Area2D) -> Hurtbox:
	var hurtbox: Hurtbox = collider as Hurtbox
	if hurtbox != null:
		return hurtbox
	return null
