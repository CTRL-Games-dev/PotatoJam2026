extends Node2D

@export_category("References")
@export var asteroid_prefabs: Array[PackedScene] = []
@export var state: GameState

@export_category("Values")

func _init() -> void:
	EventBus.round_start.connect(_on_round_start)

func _on_round_start() -> void:
	for i in range(state.asteroid_count):

		# Get new asteroid
		var asteroid_prefab: PackedScene = asteroid_prefabs.pick_random()
		var new_asteroid: Node = asteroid_prefab.instantiate() 
		
		
		add_child(new_asteroid)
