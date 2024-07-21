class_name Entity extends CharacterBody2D

func _physics_process(_delta: float) -> void:
	# "move_and_slide" already takes delta time into account
	move_and_slide()
