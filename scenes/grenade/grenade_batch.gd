extends Node2D

const FULL_TURN = 2*PI
const THROW_DISTANCE: int = 100
const NUMBER_OF_GRENADES: int = 4

@export var grenade_scene: PackedScene

func _ready() -> void:
	shoot_grenades(NUMBER_OF_GRENADES)

func shoot_grenades(number_of_grenades: int) -> void:
	var base_direction: Vector2 = Vector2.RIGHT * THROW_DISTANCE
	var direction_offset: float = FULL_TURN / number_of_grenades
	
	for n: int in number_of_grenades:
		var direction: Vector2 = base_direction.rotated(direction_offset * n)
		var grenade: Grenade = grenade_scene.instantiate()
		grenade.global_position = global_position
		grenade.target_position = global_position + direction
		AddToTreeUtils.add_mix_to_tree(grenade)
