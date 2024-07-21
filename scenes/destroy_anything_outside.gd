extends Area2D

func _ready() -> void:
	self.area_exited.connect(_destroy)
	self.body_exited.connect(_destroy)

func _destroy(node: Node) -> void:
	node.queue_free()
