class_name Grenade extends Hitbox

var target_position: Vector2 # To be set by the instantiator

var initial_position: Vector2
var intermediate_parabole_point: Vector2
var elapsed_time: float

@export var height_of_intermediate_point: float = 100
@export var speed: float = 3
@export var explosion_damage: int = 20
@export var explosion_scene: PackedScene

func _ready() -> void:
	super._ready() # Very important
	self.disable()
	
	elapsed_time = 0
	initial_position = global_position
	_calculate_intermediate_parabole_point()
	
func _process(delta: float) -> void:
	super._process(delta)
	if _has_arrived(elapsed_time):
		_explode()
	global_position = _get_bezier_position_given_time(elapsed_time)
	_process_elapsed_time(delta)

func _calculate_intermediate_parabole_point() -> void:
	var vector_to_target: Vector2 = target_position - initial_position
	var half_way_to_target: Vector2 = Vector2(vector_to_target.x/2, vector_to_target.y/2)
	var relative_intermediate_parabole_point: Vector2 = Vector2(
		half_way_to_target.x, 
		Vector2.UP.y * height_of_intermediate_point
	)
	intermediate_parabole_point = initial_position + relative_intermediate_parabole_point

# The target position is reached when time = 1. Thus time value should be between 0 and 1
func _get_bezier_position_given_time(time: float) -> Vector2:
	time = clampf(time, 0, 1)
	return _quadratic_bezier(initial_position, intermediate_parabole_point, target_position, time)

func _quadratic_bezier(p0: Vector2, p1: Vector2, p2: Vector2, t: float) -> Vector2:
	var q0: Vector2 = p0.lerp(p1, t)
	var q1: Vector2 = p1.lerp(p2, t)
	var r: Vector2 = q0.lerp(q1, t)
	return r

func _has_arrived(time: float) -> bool:
	return time >= 1
	
func _process_elapsed_time(delta: float) -> void:
	elapsed_time += delta * speed
	elapsed_time = min(elapsed_time, 1.0)

func _explode() -> void:
	var explosion: Explosion = explosion_scene.instantiate() as Explosion
	explosion.global_position = global_position
	explosion.damage = 20
	AddToTreeUtils.add_mix_to_tree(explosion)
	call_deferred("queue_free")
