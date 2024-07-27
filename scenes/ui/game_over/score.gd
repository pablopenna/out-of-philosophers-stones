extends Label

func _on_game_over_set_score(score: int):
	self.text = str(score)
