extends Node2D

const FULL_TURN: float = 2*PI
@export var initial_throw_distance: int = 50
@export var throw_distance_delta: int = 50
@export var initial_number_of_grenades: int = 6
@export var number_of_grenades_delta: int = 2
@export var number_of_volleys: int = 5
@export var delay_between_volleys: float = 0.2

@export var grenade_scene: PackedScene

func _ready() -> void:
	var throw_distance = initial_throw_distance
	var number_of_grenades = initial_number_of_grenades
	for volley:int in range(number_of_volleys):
		shoot_grenades(number_of_grenades, throw_distance)
		throw_distance += throw_distance_delta
		number_of_grenades += number_of_grenades_delta
		await get_tree().create_timer(delay_between_volleys).timeout
	call_deferred("queue_free")

func shoot_grenades(number_of_grenades: int, throw_distance: int) -> void:
	var base_direction: Vector2 = Vector2.RIGHT * throw_distance
	var direction_offset: float = FULL_TURN / number_of_grenades
	
	for n: int in number_of_grenades:
		var direction: Vector2 = base_direction.rotated(direction_offset * n)
		var grenade: Grenade = grenade_scene.instantiate()
		grenade.global_position = global_position
		grenade.target_position = global_position + direction
		AddToTreeUtils.add_mix_to_tree(grenade)
