extends Node3D

@export var bullet: PackedScene
@export var parent: Node3D
var num_bullets: int

@export var bullet_timer: Timer
@export var wave_timer: Timer

@export var num_bullets_per_wave: int = 10
@export var initial_bullet_wait_time: float = 0.1

var current_wave = 1

func _ready() -> void:
	bullet_timer.wait_time = initial_bullet_wait_time

func _on_bullet_timer_timeout() -> void:
	var new_bullet = bullet.instantiate()
	var new_position = Vector3(randf_range(-3.1, 3.1), 0.0, -5.0)
	var new_velocity = Vector3(randf_range(-0.2, 0.2), 0.0, 1.0)
	new_bullet.initialize_variables(new_position, new_velocity)
	parent.add_child(new_bullet)
	num_bullets += 1
	if num_bullets >= current_wave * num_bullets_per_wave:
		wave_timer.start()
	else:
		bullet_timer.start()

func _on_wave_timer_timeout() -> void:
	num_bullets = 0
	current_wave += 1
	bullet_timer.wait_time /= 1.5
	bullet_timer.start()
