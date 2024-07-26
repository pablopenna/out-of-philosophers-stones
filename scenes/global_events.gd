extends Node # autoloaded

signal time_in_game_passed
signal enemy_killed
signal score_updated(new_score: int)

signal player_damaged
signal shake_screen(intensity: float)

signal player_acquired_ingredient(ingredientType: AlchemyIngredient.IngredientType)
signal player_tossed_ingredient(ingredientType: AlchemyIngredient.IngredientType)
signal ingredient_ready_to_mix(ingredient: AlchemyIngredient)
