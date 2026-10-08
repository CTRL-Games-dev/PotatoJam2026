extends Node2D

@export var value: float = 1
@export var is_collected: bool = true
@onready var area_2d: Area2D = $Sprite2D/Area2D


func _process(delta: float) -> void:
	if (is_collected):
		area_2d.set_collision_mask_value(3, 0)
		#area_2d.set_collision_layer_value(3, 0)
	else:
		area_2d.set_collision_mask_value(3, 1)
		#area_2d.set_collision_layer_value(3, 1)
func _on_area_2d_area_entered(area: Area2D) -> void:
	is_collected = true
	get_tree().create_tween().tween_property($"." , "global_position", area.global_position,  0.2).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	await get_tree().create_timer(0.2).timeout
	get_tree().create_tween().tween_property($"." , "global_position", Vector2(-500, -200),  0.5).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

func change_mask() -> void:
	area_2d.set_collision_mask_value(3, 1)
	area_2d.set_collision_layer_value(3, 1)
