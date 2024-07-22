extends Sprite2D

@export var alchemy_material: AlchemyIngredient
@export var hand_texture: CompressedTexture2D
@export var eye_texture: CompressedTexture2D
@export var bone_texture: CompressedTexture2D

func _ready():
	match alchemy_material.type:
		AlchemyIngredient.IngredientType.HAND:
			self.texture = hand_texture
		AlchemyIngredient.IngredientType.EYE:
			self.texture = eye_texture
		AlchemyIngredient.IngredientType.BONE:
			self.texture = bone_texture
