class_name IngredientFactory extends Node2D

@export var ingredientScene: PackedScene
signal ingredient_created

func create_ingredient() -> void:
	var number_of_different_types = len(AlchemyIngredient.IngredientType.keys())
	var random_type: AlchemyIngredient.IngredientType = randi_range(0, number_of_different_types-1)
	
	var ingredient: AlchemyIngredient = ingredientScene.instantiate() as AlchemyIngredient
	ingredient.ingredient = random_type
	ingredient.global_position = global_position
	
	var ingredientContainer: Node = get_tree().get_first_node_in_group("IngredientContainer")
	# call_deferred is needed to avoid getting "Can't change this state while flushing queries" error when calling create_ingredient from enemy script after death
	if ingredientContainer != null:
		ingredientContainer.call_deferred("add_child", ingredient)
	else:
		get_tree().root.call_deferred("add_child", ingredient)
	
	ingredient_created.emit()
