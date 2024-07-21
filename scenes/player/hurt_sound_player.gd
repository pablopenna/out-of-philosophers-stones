extends RandomPitchAudioStreamPlayer

func _on_health_points_manager_health_decreased(_new_health_amount: int, _previous_health_amount: int) -> void:
	randomize_pitch()
	play()
