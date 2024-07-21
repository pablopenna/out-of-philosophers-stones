extends Timer

func _ready() -> void:
	self.timeout.connect(_on_timeout)
	
func _on_timeout() -> void:
	GlobalEvents.time_in_game_passed.emit()
