extends Sprite2D

var cursor_sprite: CompressedTexture2D = preload("res://art/cursor.png") as CompressedTexture2D

func _ready() -> void:
	self.texture = cursor_sprite
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	tree_exited.connect(_on_exit)

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()

func _on_exit() -> void:
	# Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	pass
