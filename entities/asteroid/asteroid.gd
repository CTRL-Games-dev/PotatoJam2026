extends Node2D

signal destroyed
@export var move_speed: float = randf()
@export var rot: float = randf_range(-0.01, 0.01)
var value: int = randi_range(5, 10)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size: float = randf_range(0.8, 1)
	rotate(randi_range(0, 360))
	apply_scale(Vector2(size, size))
	move_local_x(-randi_range(randi_range(0, 200), 650))
	rotate(randi_range(0, 360))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_local_x(move_speed)
	$Sprite2D.rotate(rot)
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	destroyed.emit(value, global_position)
	rotate(randi_range(0, 360))
	move_local_x(-1000)
