class_name TossedAlchemyIngredient extends AlchemyIngredient

const initial_linear_speed: int = 250
const acceleration: int = -300
const angular_speed: float = 1.0
var speed: float

var has_signaled: bool

@export var sprite: Sprite2D

func _ready() -> void:
	speed = initial_linear_speed
	has_signaled = false

func _physics_process(delta: float) -> void:
	_update_speed(delta)
	position += Vector2.UP * speed * delta
	sprite.rotate(angular_speed * delta)
	
	if not has_signaled and _is_ready_to_fusion():
		GlobalEvents.ingredient_ready_to_mix.emit(self)
		has_signaled = true
	
func _update_speed(delta: float) -> void:
	if speed > 0:
		speed = speed + (acceleration * delta)
		speed = max(speed, 0)

func _is_ready_to_fusion() -> bool:
	return speed == 0
