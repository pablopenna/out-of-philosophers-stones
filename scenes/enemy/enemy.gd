class_name Enemy extends Entity

var move_speed: int # Set by factory
var direction: Vector2 # Set by factory
var shoot_cooldown: float # Set by factory
var bullets_shot: int # Set by factory

@export var animation_player: AnimationPlayer
@export var hp_manager: HealthPointsManager
@export var ingredient_factory: IngredientFactory
@export var state_machine: StateMachine
@export var shoot_cooldown_timer: Timer

signal died

func _ready() -> void:
	hp_manager.health_zeroed.connect(_on_died)
	shoot_cooldown_timer.wait_time = shoot_cooldown

func _on_died() -> void:
	ingredient_factory.create_random_ingredient(true)
	
	died.emit()
	GlobalEvents.enemy_killed.emit()
	
	queue_free()

func stun(duration_in_seconds: float) -> void:
	state_machine.change_to_state(
		"stunned", 
		{
			"duration": duration_in_seconds,
		}
	)
