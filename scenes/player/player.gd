class_name Player extends Entity

@export var move_speed: int

func _physics_process(delta: float) -> void:
	velocity = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized() * move_speed
	
	super._physics_process(delta)
