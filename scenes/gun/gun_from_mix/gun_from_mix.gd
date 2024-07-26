extends Gun

@export var number_of_shots_before_destroy: int = 20
var shots_shot: int

func _ready():
	super._ready()
	shots_shot = 0
	shot.connect(_after_shot_process)
	position += Vector2(randi_range(0, 10), randi_range(0, 10)) # small offset to be seen as it is created
	
func _after_shot_process():
	shots_shot += 1
	if shots_shot >= number_of_shots_before_destroy:
		call_deferred("queue_free")
	
