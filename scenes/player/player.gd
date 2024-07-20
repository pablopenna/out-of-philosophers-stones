class_name Player extends Entity

const run_speed: int = 300
const walk_speed: int = 100
@export var animation_player: AnimationPlayer

func _ready() -> void:
	animation_player.play("Player/idle")

func _physics_process(delta: float) -> void:
	_move()
	super._physics_process(delta)

func _move() -> void:
	var move_speed: int = walk_speed if Input.is_action_pressed("walk") else run_speed
	velocity = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized() * move_speed
