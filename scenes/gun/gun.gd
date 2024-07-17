extends Node2D

func _process(_delta: float) -> void:
	var mouse_position: Vector2 = get_global_mouse_position()
	var rotation_to_mouse: float = global_position.angle_to_point(mouse_position)
	
	rotation = rotation_to_mouse
