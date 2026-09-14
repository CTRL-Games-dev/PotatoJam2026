extends Node2D

@export var move_speed: float = 5
@export var min_distance: float = 4
@export var distance_speed_multiplier: float = 3 

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var distance: float = (mouse_pos - position).length() 

	var move_delta: float = move_speed
	move_delta += max(0, distance - min_distance) * distance_speed_multiplier

	var new_pos = position.move_toward(mouse_pos, move_delta * delta)

	position = new_pos
	
