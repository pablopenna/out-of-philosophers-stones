class_name IngredientFactory extends Node2D

@export var ingredientScene: PackedScene

func create_ingredient() -> void:
	var number_of_different_types = len(AlchemyIngredient.IngredientType.keys())
	var random_type: AlchemyIngredient.IngredientType = randi_range(0, number_of_different_types-1)
	
	var ingredient: AlchemyIngredient = ingredientScene.instantiate() as AlchemyIngredient
	ingredient.ingredient = random_type
	
	var ingredientContainer: Node = get_tree().get_first_node_in_group("IngredientContainer")
	if ingredientContainer != null:
		ingredientContainer.add_child(ingredient)
	else:
		get_tree().root.add_child(ingredient)
