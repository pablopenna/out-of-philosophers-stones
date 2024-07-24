class_name IngredientMixer extends Node2D

@export var gun_scene: PackedScene
@export var bazooka_scene: PackedScene
@export var aegis_scene: PackedScene
@export var grenade_batch_scene: PackedScene

var mixing_queue: Array[AlchemyIngredient]

func _ready() -> void:
	mixing_queue = []
	GlobalEvents.ingredient_ready_to_mix.connect(_add_ingredient_to_mix_queue)
	
func _add_ingredient_to_mix_queue(ingredient: AlchemyIngredient) -> void:
	mixing_queue.append(ingredient)
	if _can_mix():
		_mix_ingredients()
	
func _can_mix() -> bool:
	return len(mixing_queue) >= 2

func _mix_ingredients() -> void:
	var first: AlchemyIngredient = mixing_queue.pop_front() as AlchemyIngredient
	var second: AlchemyIngredient = mixing_queue.pop_front() as AlchemyIngredient
	var mix_scene: PackedScene = _get_mixing_ingredients_result(first.type, second.type)
	var mix: Node2D = mix_scene.instantiate()
	mix.global_position = global_position
	AddToTreeUtils.add_mix_to_tree(mix)

func _get_mixing_ingredients_result(
	first_type: AlchemyIngredient.IngredientType, 
	second_type: AlchemyIngredient.IngredientType
) -> PackedScene:
	var ingredients: Array[AlchemyIngredient.IngredientType] = [first_type, second_type]
	# match does not care about order of elements within array
	match ingredients: 
		[AlchemyIngredient.IngredientType.BONE, _]:
			return aegis_scene
		[AlchemyIngredient.IngredientType.HAND, _]:
			return bazooka_scene
		[AlchemyIngredient.IngredientType.EYE, _]:
			return grenade_batch_scene
		_:
			return gun_scene
	
