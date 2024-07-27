extends LoadableScreen

func _ready():
	var game_over_iu = get_child(0)
	game_over_iu.set_score.emit(parameters["score"])
