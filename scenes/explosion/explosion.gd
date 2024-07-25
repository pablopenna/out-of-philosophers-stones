class_name Explosion extends Hitbox

var damage: int = 100
@export var animation_player: AnimationPlayer

func _ready() -> void:
	super._ready()
	self.hitbox_data = HitboxData.new()
	self.hitbox_data.damage = damage
	animation_player.play("default")

func _explosion_start() -> void:
	self.enable()

func _explosion_end() -> void:
	self.disable()
	call_deferred("queue_free")
