extends State

var enemy: Enemy
var original_velocity: Vector2

@export var animation_player: AnimationPlayer

func _ready() -> void:
	state_name = "stunned"
	
func enter(context: Dictionary) -> void:
	enemy = (managed_node as Enemy)
	original_velocity = enemy.velocity
	var previous_state: String = context.get("previous_state")
	var stun_duration: int = context.get("duration")
	
	enemy.velocity = Vector2.ZERO
	animation_player.stop()
	
	await get_tree().create_timer(stun_duration).timeout
	change_to_state.emit(previous_state, {})

func exit(_new_state: State) -> void:
	enemy.velocity = original_velocity
