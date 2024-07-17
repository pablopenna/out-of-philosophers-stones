class_name Entity extends CharacterBody2D

@onready var facing_direction: Vector2 = Vector2.DOWN

func _physics_process(_delta: float) -> void:
	_update_facing_direction()
	# "move_and_slide" already takes delta time into account
	move_and_slide()
	
func _update_facing_direction() -> void:
	facing_direction = FacingDirectionUtils.getFacingDirectionFromVelocityWithDefault(velocity, facing_direction)
