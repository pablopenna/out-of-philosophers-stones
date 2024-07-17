class_name HealthPointsManager extends Node

@export var hurtbox: Hurtbox
@export var health: int

signal health_decreased(new_health_amount: int, previous_health_amount: int)
signal health_increased(new_health_amount: int, previous_health_amount: int)
signal health_zeroed

func _ready() -> void:
	hurtbox.damaged.connect(_on_hurtbox_triggered)
	
func _on_hurtbox_triggered(hitboxData: HitboxData) -> void:
	var initial_health: int = self.health
	var new_health: int = initial_health - hitboxData.damage
	self.health = new_health
	
	health_decreased.emit(new_health, initial_health)
	if self.health <= 0:
		health_zeroed.emit()
