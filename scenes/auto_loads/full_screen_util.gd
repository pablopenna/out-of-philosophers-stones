extends Node # Autoload

var _is_fullscreen: bool

func _ready():
	_is_fullscreen = false

func toggle_fullscreen():
	if not _is_fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		_is_fullscreen = true
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		_is_fullscreen = false

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		toggle_fullscreen()
		
