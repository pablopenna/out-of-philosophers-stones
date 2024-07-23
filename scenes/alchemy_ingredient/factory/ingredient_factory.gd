class_name IngredientFactory extends Node2D

@export var ingredientScene: PackedScene
@export var tossedIngredientScene: PackedScene

func create_ingredient(
	ingredient_type: AlchemyIngredient.IngredientType, 
	add_to_tree: bool = false
) -> AlchemyIngredient:
	var ingredient: AlchemyIngredient = ingredientScene.instantiate() as AlchemyIngredient
	ingredient.type = ingredient_type
	ingredient.global_position = global_position
	
	if add_to_tree:
		AddToTreeUtils.add_ingredient_to_tree(ingredient)
	
	return ingredient

func create_random_ingredient(add_to_tree: bool = false) -> AlchemyIngredient:
	var number_of_different_types: int = len(AlchemyIngredient.IngredientType.keys())
	var random_type: AlchemyIngredient.IngredientType = randi_range(0, number_of_different_types - 1)
	
	var ingredient: AlchemyIngredient = create_ingredient(random_type, add_to_tree)
	
	return ingredient

func create_tossed_ingredient(ingredient_type: AlchemyIngredient.IngredientType) -> TossedAlchemyIngredient:
	var ingredient := tossedIngredientScene.instantiate() as TossedAlchemyIngredient
	ingredient.type = ingredient_type
	
	return ingredient
	
