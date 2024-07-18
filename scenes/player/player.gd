class_name Player extends Entity

const move_speed: int = 300
@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play("Player/idle")

func _physics_process(delta: float) -> void:
	velocity = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized() * move_speed
	
	super._physics_process(delta)
