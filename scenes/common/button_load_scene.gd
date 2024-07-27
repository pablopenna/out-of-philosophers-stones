extends Button

@export var scene_to_load: SceneLoaderUtil.LoadableScene

func _ready() -> void:
	pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	SceneLoaderUtil.load_screen_to_scene(scene_to_load)
