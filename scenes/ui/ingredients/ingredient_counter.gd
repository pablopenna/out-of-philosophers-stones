extends Label

var counter: int
@export var tracked_ingredient_type: AlchemyIngredient.IngredientType

func _ready() -> void:
	counter = 0
	GlobalEvents.player_acquired_ingredient.connect(_on_player_acquired_ingredient)
	
func _on_player_acquired_ingredient(ingredient: AlchemyIngredient, player_stash: Dictionary) -> void:
	if ingredient.ingredient == tracked_ingredient_type:
		counter += 1
		self.text = str(counter)
