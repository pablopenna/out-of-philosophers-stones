extends Button

func _ready():
	pressed.connect(_fullscreen)

func _fullscreen():
	FullScreenUtil.toggle_fullscreen()
