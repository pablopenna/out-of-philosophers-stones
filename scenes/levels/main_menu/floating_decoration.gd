extends TextureRect

@export var move_range: int = 10
@export var image_files: Array[CompressedTexture2D]
var base_position: Vector2
var time_elapsed: float

func _ready() -> void:
	self.texture = image_files[randi_range(0, len(image_files)-1)]
	base_position = global_position
	move_range = move_range + randi_range(-move_range, move_range)
	time_elapsed = randf_range(0, 100)

func _process(delta: float) -> void:
	time_elapsed += delta
	global_position = base_position + (Vector2.UP * move_range * sin(time_elapsed))
