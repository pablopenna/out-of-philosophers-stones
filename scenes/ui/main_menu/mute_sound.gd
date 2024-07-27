extends Button

func _ready():
	pressed.connect(_on_pressed)
	
func _on_pressed() -> void:
	if GlobalMusicPlayer.playing:
		GlobalMusicPlayer.stop()
	else:
		GlobalMusicPlayer.play()
