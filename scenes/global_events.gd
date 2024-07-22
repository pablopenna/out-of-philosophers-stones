extends Node # autoloaded

signal time_in_game_passed
signal enemy_killed
signal player_damaged

signal player_acquired_ingredient(ingredientType: AlchemyIngredient.IngredientType)
signal player_tossed_ingredient(ingredientType: AlchemyIngredient.IngredientType)

signal score_updated(new_score: int)
