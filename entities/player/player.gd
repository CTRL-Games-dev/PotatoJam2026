extends Node2D


@export var move_speed: float = 5
@export var base_rotation_speed: float = 5
@export var rotation_speed: float = 5
@export var min_distance: float = 4
@export var distance_speed_multiplier: float = 3 
@export var base_attack_speed: float = 1
@export var attack_speed: float = base_attack_speed
@onready var target_position: Vector2 = get_global_mouse_position()
@onready var selection: Sprite2D = $selection
@onready var recovery_timer: Timer = $RecoveryTimer
@onready var startup_timer: Timer = $StartupTimer
@onready var active_timer: Timer = $ActiveTimer
@onready var collision_shape_2d: CollisionShape2D = $Sprite2D2/WeaponArea2D/CollisionShape2D

var target: Area2D
var old_rotation: float
var angle: float = 0
var angle_offset: float = 0
var target_list: Array[Area2D] = []
enum State{
	NEUTRAL,
	STARTUP,
	ATTACK
}
@export var state: State = State.NEUTRAL


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var mouse_pos: Vector2 = get_global_mouse_position()
	var distance: float = (mouse_pos - position).length() 

	var move_delta: float = move_speed
	move_delta += max(0, distance - min_distance) * distance_speed_multiplier

	var new_pos = position.move_toward(mouse_pos, move_delta * delta)
	position = new_pos
	
	if (target_list.size() > 0):
		target = target_list[0] 
		selection.visible = true
		target_position = target.global_position
	else:
		selection.visible = false
	
	selection.global_position = target_position
	
	var rotation_difference = target_position - self.global_position
	
	angle = rotation_difference.angle() + angle_offset

	old_rotation = self.global_rotation
	
	self.global_rotation = lerp_angle(old_rotation, angle, delta * rotation_speed)
		
		
		
	if (state == State.NEUTRAL):
		if (target):
			kesagiri()
			
	elif (state == State.STARTUP):
		pass
		
			
	elif (state == State.ATTACK):
		if(active_timer.time_left < attack_speed/1 && active_timer.time_left > attack_speed/1.5):
			collision_shape_2d.disabled = false
		else:
			collision_shape_2d.disabled = true
			
			
	#print("Recovery: ", recovery_timer.time_left)
	#print("Startup: ", startup_timer.time_left)
	#print("Active: ", active_timer.time_left)
		
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	target_list.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	target_list.pop_at(target_list.find(area))
	
	

func kesagiri() -> void:
	rotation_speed = 5 / base_attack_speed



func _on_recovery_timer_timeout() -> void:
	state = State.STARTUP
	angle_offset = 0.5
	attack_speed = base_attack_speed/3
	startup_timer.start(attack_speed)


func _on_startup_timer_timeout() -> void:
	state = State.ATTACK
	angle_offset *= -2
	rotation_speed = base_rotation_speed * 3
	attack_speed = base_attack_speed/5
	active_timer.start(attack_speed)


func _on_active_timer_timeout() -> void:
	state = State.NEUTRAL
	attack_speed = base_attack_speed
	rotation_speed = base_rotation_speed
	angle_offset = 0
	recovery_timer.start(attack_speed)
