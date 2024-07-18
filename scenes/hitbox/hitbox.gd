# The hitbox scans for hurtboxes by setting its mask to match the layer the hurtboxes are in
# We can set the layer of the hitbox so it can be detected by other collisions
class_name Hitbox extends Area2D

@export var entity_to_track: Entity
@export var hitbox_data: HitboxData
signal hit

func _ready() -> void: 
	area_entered.connect(_on_area_entered)
	# hitbox_data = find_children("*", "HitboxData")[0]
	
func _process(_delta) -> void:
	if entity_to_track:
		_flip_horizontally_if_entity_facing_left()
		_set_position_relative_to_entity()
	
func _on_area_entered(area: Area2D) -> void:
	var hurtbox = area as Hurtbox # Casting returns null if cannot convert to type
	if hurtbox == null:
		return	
	_on_hurtbox_entered(hurtbox)
	
func enable() -> void:
	monitoring = true
	monitorable = true

func disable() -> void:
	monitoring = false
	monitorable = false
	
func _on_hurtbox_entered(hurtbox: Hurtbox) -> void:
	hit.emit()
	_on_hit(hurtbox, hitbox_data)
	hurtbox.receiveDamage(hitbox_data)

func _on_hit(hurtbox: Hurtbox, hitbox_data: HitboxData):
	pass
	
func _flip_horizontally_if_entity_facing_left() -> void:
	if entity_to_track.facing_direction == Vector2.LEFT:
		self.scale.x = -1
	else:
		self.scale.x = 1
		
func _set_position_relative_to_entity() -> void:
	self.global_position = entity_to_track.global_position
