class_name IngredientStash extends Area2D

var _stash: Dictionary

func _ready() -> void:
	_initialize_stash()
	self.area_entered.connect(_process_collision)

func toss(ingredientType: AlchemyIngredient.IngredientType) -> void:
	pass

func _initialize_stash() -> void:
	_stash = {}
	for type in AlchemyIngredient.IngredientType.values(): # Enum is a dictionary under the hood it seems. Need the int values for _pickup to work properly as Ingredient.ingredient returns int
		_stash[type] = 0

func _pickup(ingredient: AlchemyIngredient) -> void:
	_stash[ingredient.ingredient] += 1
	ingredient.queue_free() # Remove from floor after picking it up
	print(_stash)

func _process_collision(area: Area2D) -> void:
	var ingredient = area as AlchemyIngredient
	if ingredient != null:
		_pickup(ingredient)
