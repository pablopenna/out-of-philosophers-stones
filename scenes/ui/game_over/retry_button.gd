extends Button

func _on_pressed():
	get_tree().change_scene_to_file.call_deferred("res://scenes/levels/game.tscn")
