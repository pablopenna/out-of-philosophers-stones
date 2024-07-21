extends Area2D

var tracked_bullets: Array[Area2D]
var MAX_DISTANCE: float
var MIN_DISTANCE: float

@export var sprites_to_provide_param_to_shader: Array[Sprite2D]
const shader_param_name: StringName = "intensity"

func _ready() -> void:
	self.area_entered.connect(_on_bullet_entered)
	self.area_exited.connect(_on_bullet_entered)
	MAX_DISTANCE = (($CollisionShape2D as CollisionShape2D).shape as CircleShape2D).radius
	MIN_DISTANCE = 0
	
func _process(_delta: float) -> void:
	var closest_distance: float = _calculate_distance_to_closest_bullet()
	var value_for_shaders: float = _magic_value_between_0_and_1(closest_distance)
	_provide_param_to_sprite_shaders(value_for_shaders)
	
	#print("MAX ", MAX_DISTANCE)
	#print("closest dist ", closest_distance)
	#print("closest value ", value_for_shaders)
	
func _provide_param_to_sprite_shaders(param_value: float) -> void:
	for sprite: Sprite2D in sprites_to_provide_param_to_shader:
		(sprite.material as ShaderMaterial).set_shader_parameter("intensity", param_value)

# Given a Max and Min value, code a function that returns a value between 0 or 1 depending on  how close the value received as parameter is to the Min or the Max values. The return value should be closer to 1 the closer the parameter is to the Min value. The return value should be closer to 0 the closer the parameter is to the Max value.
# This only works if MIN_DISTANCE is 0
func _magic_value_between_0_and_1(value: float) -> float:
	return (MAX_DISTANCE - value) / MAX_DISTANCE

func _calculate_distance_to_closest_bullet() -> float:
	var distance_to_closest_bullet: float = MAX_DISTANCE
	for bullet: Area2D in tracked_bullets:
		if bullet == null: 
			continue
		var distance_to_bullet: float = _distance_to_bullet(bullet)
		if distance_to_bullet < distance_to_closest_bullet:
			distance_to_closest_bullet = distance_to_bullet
	return distance_to_closest_bullet
	
func _distance_to_bullet(bullet: Area2D) -> float:
	var distance: float = global_position.distance_to(bullet.global_position)
	return max(distance, MIN_DISTANCE)
	
func _on_bullet_entered(area: Area2D) -> void:
	tracked_bullets.append(area)

func _on_bullet_exited(area: Area2D) -> void:
	tracked_bullets.erase(area)
