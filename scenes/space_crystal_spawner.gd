extends Node2D

@export_category("References")
@export var crystal_prefabs: Array[PackedScene] = []
@export var state: GameState

@export_category("Values")

func _init() -> void:
	EventBus.round_start.connect(_on_round_start)

func _on_round_start() -> void:
	for i in range(10):

		# Get new asteroid
		var crystal_prefab: PackedScene = crystal_prefabs.pick_random()
		var new_crystal: Node = crystal_prefab.instantiate() 
		
		
		add_child(new_crystal)
	
	for asteroid in get_tree().get_nodes_in_group("asteroids"):
		asteroid.connect("destroyed", spawn_crystals)

func spawn_crystals(amount, position) -> void:
	for child: Node2D in get_children():
		child.global_rotation = randi_range(0, PI*2)
		child.global_position = position
		get_tree().create_tween().tween_property(child, "position:x", -50, 0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
		print(child.global_position)
		
