class_name DifficultyManager extends Node

enum Parameter {
	ENEMY_VELOCITY_RANGE,
	ENEMY_BULLETS_SHOT,
	ENEMY_SHOOT_COOLDOWN,
	ENEMY_SPAWN_COOLDOWN
}

static func _get_difficulty_params(score: int) -> Dictionary:
	if score < 50:
		return {
			Parameter.ENEMY_VELOCITY_RANGE: [100, 125],
			Parameter.ENEMY_BULLETS_SHOT: 4,
			Parameter.ENEMY_SHOOT_COOLDOWN: 2,
			Parameter.ENEMY_SPAWN_COOLDOWN: 2,
		}
	if score < 120:
		return {
			Parameter.ENEMY_VELOCITY_RANGE: [125, 175],
			Parameter.ENEMY_BULLETS_SHOT: 6,
			Parameter.ENEMY_SHOOT_COOLDOWN: 1.5,
			Parameter.ENEMY_SPAWN_COOLDOWN: 1.5,
		}
	if score < 280:
		return {
			Parameter.ENEMY_VELOCITY_RANGE: [175, 200],
			Parameter.ENEMY_BULLETS_SHOT: 6,
			Parameter.ENEMY_SHOOT_COOLDOWN: 1,
			Parameter.ENEMY_SPAWN_COOLDOWN: 1,
		}
	if score < 500:
		return {
			Parameter.ENEMY_VELOCITY_RANGE: [175, 250],
			Parameter.ENEMY_BULLETS_SHOT: 8,
			Parameter.ENEMY_SHOOT_COOLDOWN: 1,
			Parameter.ENEMY_SPAWN_COOLDOWN: 1,
		}
	else:
		return {
			Parameter.ENEMY_VELOCITY_RANGE: [175, 250],
			Parameter.ENEMY_BULLETS_SHOT: 8,
			Parameter.ENEMY_SHOOT_COOLDOWN: 0.8,
			Parameter.ENEMY_SPAWN_COOLDOWN: 0.8,
		}
