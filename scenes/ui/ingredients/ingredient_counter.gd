extends Label

var counter: int
@export var tracked_ingredient_type: AlchemyIngredient.IngredientType

func _ready() -> void:
	counter = 0
	GlobalEvents.player_acquired_ingredient.connect(_on_player_acquired_ingredient)
	GlobalEvents.player_tossed_ingredient.connect(_on_player_tossed_ingredient)
	
func _on_player_acquired_ingredient(type: AlchemyIngredient.IngredientType) -> void:
	if type == tracked_ingredient_type:
		counter += 1
		self.text = str(counter)

func _on_player_tossed_ingredient(type: AlchemyIngredient.IngredientType) -> void:
	if type == tracked_ingredient_type:
		counter -= 1
		self.text = str(counter)
