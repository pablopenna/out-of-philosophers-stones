extends Node

var score: int

const score_added_for_killed_enemy: int = 10
const score_added_for_time_in_game_passed: int = 1

func _ready() -> void:
	score = 0
	GlobalEvents.enemy_killed.connect(_on_enemy_killed)
	GlobalEvents.time_in_game_passed.connect(_on_time_passed)
	GlobalEvents.player_dead.connect(_game_over)

func _on_enemy_killed() -> void:
	_increase_score(score_added_for_killed_enemy)
	
func _on_time_passed() -> void:
	_increase_score(score_added_for_time_in_game_passed)

func _increase_score(increase: int) -> void:
	score += increase
	GlobalEvents.score_updated.emit(score)
	
func _game_over() -> void:
	GlobalEvents.show_gameover_screen.emit(score)
	get_tree().change_scene_to_file.call_deferred("res://scenes/levels/game_over.tscn")
	
