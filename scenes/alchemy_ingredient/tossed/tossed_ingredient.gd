class_name TossedAlchemyIngredient extends AlchemyIngredient

const initial_linear_speed: int = 250
const acceleration: int = -300
const angular_speed: float = 1.0
var speed: float

@export var sprite: Sprite2D

func _ready() -> void:
	speed = initial_linear_speed

func _physics_process(delta: float) -> void:
	_update_speed(delta)
	
	position += Vector2.UP * speed * delta
	sprite.rotate(angular_speed * delta)
	
func _update_speed(delta) -> void:
	if speed > 0:
		speed = speed + (acceleration * delta)
		speed = max(speed, 0)
	
