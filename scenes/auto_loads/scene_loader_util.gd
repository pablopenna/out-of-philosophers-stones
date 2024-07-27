extends Node # Autoload

enum LoadableScene {
	MAIN_MENU,
	GAME,
	GAME_OVER
}

var _scene_path_catalog: Dictionary = {
	LoadableScene.MAIN_MENU: "res://scenes/levels/main_menu.tscn",
	LoadableScene.GAME: "res://scenes/levels/game.tscn",
	LoadableScene.GAME_OVER: "res://scenes/levels/game_over.tscn"
}

## Opens a loading screen to load the target scene from the resource path.
## target: The target scene resource path
## parameters: An optional set of parameters to pass to the new scene. Keep in mind the target scene needs to understand the parameters for them to work.
func load_screen_to_scene(target: LoadableScene, parameters: Dictionary = {}) -> void:
	var loading_screen = preload("res://scenes/loading_screen/loading_screen.tscn").instantiate() # Godot handles loading the loading screen upon game startup. We'll instance a new one here.
	var next_scene_path = _scene_path_catalog[target]
	loading_screen.next_scene_path = next_scene_path # Assign the next scene to the loader so it knows what to load
	loading_screen.parameters = parameters # And the parameters to pass along
	get_tree().current_scene.add_child(loading_screen) # Add the loading screen to the current scene. Note that this does not replace the current scene, so if you want the current scene to stop doing things, you'll need to pause it.
	
	
	
