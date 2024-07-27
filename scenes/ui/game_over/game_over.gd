extends CanvasLayer

signal set_score(score: int)

func _ready() -> void:
	# visible = false
	GlobalEvents.show_gameover_screen.connect(show_game_over)
	
func show_game_over(score: int) -> void:
	set_score.emit(score)
	visible = true
