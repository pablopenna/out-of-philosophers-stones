class_name Enemy extends Entity

const move_speed: int = 300
@export var animation_player: AnimationPlayer
@export var hp_manager: HealthPointsManager
@export var ingredient_factory: IngredientFactory

signal died

func _ready() -> void:
	animation_player.play("Enemy/idle")
	hp_manager.health_zeroed.connect(_on_died)

func _on_died() -> void:
	ingredient_factory.create_random_ingredient(true)
	
	died.emit()
	GlobalEvents.enemy_killed.emit()
	
	queue_free()
