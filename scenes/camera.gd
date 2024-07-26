extends Camera2D

@export var target: Node2D

# Multiplier for lerping the shake strength to zero
@export var decay_rate: float = 10.0
var shake_strength: float

func _ready() -> void:
	shake_strength = 0
	GlobalEvents.shake_screen.connect(_start_screenshake)

func _process(delta: float) -> void:
	if target:
		global_position = target.global_position
	_process_screenshake(delta)

func _start_screenshake(intensity: float) -> void:
	shake_strength = intensity

func _process_screenshake(delta: float) -> void:
	if shake_strength > 0:
		shake_strength = lerp(shake_strength, 0.0, decay_rate * delta)
		self.offset = _get_random_offset()
	
func _get_random_offset() -> Vector2:
	return Vector2(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength, shake_strength)
	)
