class_name State extends Node

# Context is used to pass parameters across states. This way we do not have to define 
# variables in the managedEntity for this purpose that end up being global variables.
# If a state needs to get a value from passed by another state, they should use the context
signal change_to_state(stateName: String, context: Dictionary)

var managed_node: Node
# Use this property rather than the node name to define the state name
# StateManager uses this as the dict key where states are stored
var state_name: String

func enter(context: Dictionary) -> void:
	pass
	
func process(delta: float) -> void:
	pass
	
func physics_process(delta: float) -> void:
	pass

func exit(new_state: State) -> void:
	pass

