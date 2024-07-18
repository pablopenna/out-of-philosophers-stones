class_name Projectile extends Hitbox

var direction: Vector2
var speed: float
var damage: int

signal outOfScreen

func _ready() -> void:
	super._ready()
	hitbox_data = HitboxData.new()
	hitbox_data.damage = damage

func _process(delta) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	self._destroy()

func _on_hit(hurtbox: Hurtbox, hitbox_data: HitboxData) -> void:
	self._destroy()

func _destroy() -> void:
	queue_free()
