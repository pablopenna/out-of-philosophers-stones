extends Container

@export var number_of_decorations: int = 20
@export var decoration_scene: PackedScene

func _ready():
	var size = self.get_parent_control().size
	for i:int in range(number_of_decorations):
		var decoration = decoration_scene.instantiate()
		decoration.global_position = Vector2(
			randi_range(0, size.x - 16),
			randi_range(0, size.y),
		)
		add_child(decoration)
