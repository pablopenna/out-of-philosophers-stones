class_name IngredientStash extends Area2D

var _stash: Dictionary
@export var ingredient_factory: IngredientFactory

signal ingredient_picked_up(ingredient: AlchemyIngredient)

func _ready() -> void:
	_initialize_stash()
	self.area_entered.connect(_process_collision)

func get_stash() -> Dictionary:
	return _stash

func toss(ingredientType: AlchemyIngredient.IngredientType) -> bool:
	if not _has_remaining_ingredients_of_type(ingredientType):
		return false
	_stash[ingredientType] -= 1
	var ingredient: TossedAlchemyIngredient = ingredient_factory.create_tossed_ingredient(ingredientType)
	
	# ingredient.global_position = global_position
	# AddToTreeUtils.add_ingredient_to_tree(ingredient)
	add_child(ingredient) # Make tossed ingredients follow the "tosser"
	
	return true

func _has_remaining_ingredients_of_type(ingredientType: AlchemyIngredient.IngredientType) -> bool:
	return _stash[ingredientType] > 0
	

func _initialize_stash() -> void:
	_stash = {}
	for type in AlchemyIngredient.IngredientType.values(): # Enum is a dictionary under the hood it seems. Need the int values for _pickup to work properly as Ingredient.ingredient returns int
		_stash[type] = 0

func _pickup(ingredient: AlchemyIngredient) -> void:
	_stash[ingredient.type] += 1
	ingredient_picked_up.emit(ingredient)
	ingredient.queue_free() # Remove from floor after picking it up

func _process_collision(area: Area2D) -> void:
	var ingredient = area as AlchemyIngredient
	if ingredient != null:
		_pickup(ingredient)
