extends Node2D

@export_category("References")
@export var crystal_prefabs: Array[PackedScene] = []
@export var state: GameState
@export_category("Values")

var spread: int = 20

func _init() -> void:
	EventBus.round_start.connect(_on_round_start)

func _on_round_start() -> void:
	for i in range(100):

		# Get new asteroid
		var crystal_prefab: PackedScene = crystal_prefabs.pick_random()
		var new_crystal: Node = crystal_prefab.instantiate() 
		
		
		add_child(new_crystal)
	
	for asteroid in get_tree().get_nodes_in_group("asteroids"):
		asteroid.connect("destroyed", spawn_crystals)

func spawn_crystals(amount, position) -> void:
	var i = 0
	for child: Node2D in get_children():
		print(child.is_collected)
		if (child.is_collected):
			child.global_position = position
			get_tree().create_tween().tween_property(child, "global_position", Vector2(
				child.global_position.x+randi_range(-spread, spread),
				child.global_position.y+randi_range(-spread, spread)), 
				0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
			child.change_mask
			i+=1
			child.is_collected = false
		if (i >= amount):
			break
