class_name RandomPitchAudioStreamPlayer extends AudioStreamPlayer

@export var max_pitch: float = 1.1
@export var min_pitch: float = 0.9

func _randomize_pitch() -> void:
	var new_pitch: float = randf_range(min_pitch, max_pitch)
	self.pitch_scale = new_pitch

func play_with_random_pitch() -> void:
	_randomize_pitch()
	play()
