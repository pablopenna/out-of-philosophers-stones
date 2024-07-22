class_name StateMachine extends Node

var states: Dictionary
var current_state: State = initial_state
@export var initial_state: State
@export var managed_node: Node

signal state_changed(new_state: String, old_state: String, context: Dictionary)

func _ready() -> void:
	states = get_children_as_state_dictionary()
	initialize_states()
	current_state = initial_state
	initial_state.enter({})
	
func _process(delta: float) -> void:
	current_state.process(delta)

func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)

func get_children_as_state_dictionary() -> Dictionary:
	var children: Array[Node] = self.get_children()
	var states: Dictionary = {}
	
	for child: State in children as Array[State]:
		states[child.state_name] = child
		
	return states
	
func initialize_states() -> void:
	for stateKey: String in states:
		var state: State = states[stateKey]
		
		state.change_to_state.connect(change_to_state)
		state.managed_node = managed_node

func change_to_state(new_state_name: String, context: Dictionary) -> void:
	var old_state: State = current_state
	var new_state: State = states[new_state_name]
	
	old_state.exit(new_state)
	current_state = new_state
	new_state.enter(context)
	
	state_changed.emit(new_state_name, old_state.state_name, context)
