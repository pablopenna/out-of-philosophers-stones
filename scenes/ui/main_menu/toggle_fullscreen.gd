extends Button

var is_fullscreen: bool

func _ready():
	is_fullscreen = false
	pressed.connect(_fullscreen)

func _fullscreen():
	if not is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		is_fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		is_fullscreen = false
