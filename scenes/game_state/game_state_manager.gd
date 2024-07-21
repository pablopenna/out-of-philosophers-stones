extends Node # autoloaded

var score: int = 0

const score_added_for_killed_enemy: int = 10
const score_added_for_time_in_game_passed: int = 1

func _ready() -> void:
	score = 0
	GlobalEvents.enemy_killed.connect(_on_enemy_killed)
	GlobalEvents.time_in_game_passed.connect(_on_time_passed)

func _on_enemy_killed() -> void:
	_increase_score(score_added_for_killed_enemy)
	
func _on_time_passed() -> void:
	_increase_score(score_added_for_time_in_game_passed)

func _increase_score(increase: int) -> void:
	score += increase
	GlobalEvents.score_updated.emit(score)
