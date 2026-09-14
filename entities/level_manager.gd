extends Node2D

func _ready() -> void:
    EventBus.round_start.emit()

func _process(delta: float) -> void:
    pass