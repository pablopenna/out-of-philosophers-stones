extends Label

func _ready() -> void:
	GlobalEvents.score_updated.connect(_on_score_updated)

func _on_score_updated(new_score: int) -> void:
	self.text = str(new_score)
