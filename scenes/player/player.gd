class_name Player extends Entity

const run_speed: int = 300
const walk_speed: int = 100
@export var animation_player: AnimationPlayer
@export var hp_manager: HealthPointsManager
@export var ingredient_stash: IngredientStash

func _ready() -> void:
	animation_player.play("Player/idle")
	hp_manager.health_decreased.connect(_on_damaged)
	hp_manager.health_zeroed.connect(_on_death)
	ingredient_stash.ingredient_picked_up.connect(_on_ingredient_picked_up)

func _physics_process(delta: float) -> void:
	_move()
	_process_toss_ingredients()
	super._physics_process(delta)

func _move() -> void:
	var move_speed: int = walk_speed if Input.is_action_pressed("walk") else run_speed
	velocity = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	).normalized() * move_speed
	
func _process_toss_ingredients() -> void:
	if Input.is_action_just_pressed("toss_bone"):
		_toss_ingredient(AlchemyIngredient.IngredientType.BONE)
	if Input.is_action_just_pressed("toss_eye"):
		_toss_ingredient(AlchemyIngredient.IngredientType.EYE)
	if Input.is_action_just_pressed("toss_hand"):
		_toss_ingredient(AlchemyIngredient.IngredientType.HAND)

func _toss_ingredient(type: AlchemyIngredient.IngredientType) -> void:
	if ingredient_stash.toss(type):
		GlobalEvents.player_tossed_ingredient.emit(type)

func _on_damaged(_new_health_amount: int, _previous_health_amount: int) -> void:
	GlobalEvents.player_damaged.emit()
	
func _on_death() -> void:
	call_deferred("queue_free")
	GlobalEvents.player_dead.emit()
	
func _on_ingredient_picked_up(ingredient: AlchemyIngredient) -> void:
	GlobalEvents.player_acquired_ingredient.emit(ingredient.type)
	
