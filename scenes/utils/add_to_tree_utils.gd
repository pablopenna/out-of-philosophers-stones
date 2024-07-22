extends Node # To be autoloaded

const INGREDIENT_CONTAINER_GROUP: String = "IngredientContainer"
const PROJECTILE_CONTAINER_GROUP: String = "ProjectileContainer"

func add_node_to_tree(node: Node, container_with_group: String) -> void:
	var ingredientContainer: Node = get_tree().get_first_node_in_group(container_with_group)
	# call_deferred is needed to avoid getting "Can't change this state while flushing queries" error when calling create_ingredient from enemy script after death
	if ingredientContainer != null:
		ingredientContainer.call_deferred("add_child", node)
	else:
		get_tree().root.call_deferred("add_child", node)

func add_ingredient_to_tree(ingredient: AlchemyIngredient) -> void:
	add_node_to_tree(ingredient, INGREDIENT_CONTAINER_GROUP)

func add_projectile_to_tree(projectile: Projectile) -> void:
	add_node_to_tree(projectile, PROJECTILE_CONTAINER_GROUP)
