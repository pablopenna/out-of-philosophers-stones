extends HBoxContainer

@export var hp_ui_element_scene: PackedScene
@export var player_hp: int

func _ready() -> void:
	for n: int in player_hp:
		add_child(hp_ui_element_scene.instantiate())
		
	GlobalEvents.player_damaged.connect(_on_player_damaged)

func _on_player_damaged() -> void:
	if(self.get_child_count() > 0):
		self.remove_child(self.get_child(0))
