extends Node3D

@export var bullet: PackedScene
@export var parent: Node3D
var num_bullets: int

@export var bullet_timer: Timer
@export var wave_timer: Timer

@export var num_bullets_per_wave: int = 10
@export var initial_bullet_wait_time: float = 0.1

@export var num_initial_bullets: int = 50000

var current_wave = 1

func _ready() -> void:
	bullet_timer.wait_time = initial_bullet_wait_time
	
	for i in range(num_initial_bullets):
		var new_bullet = bullet.instantiate()
		BulletPool.add_child(new_bullet)
		BulletPool.add_to_pool(new_bullet)

func _on_bullet_timer_timeout() -> void:
	var new_bullet = BulletPool.pull_from_pool()
	new_bullet.position = Vector3(randf_range(-3.1, 3.1), 0.0, -5.0)
	new_bullet.velocity = Vector3(randf_range(-0.2, 0.2), 0.0, 1.0)
	num_bullets += 1
	if num_bullets >= current_wave * num_bullets_per_wave:
		print_debug("end wave")
		wave_timer.start()
	else:
		bullet_timer.start()

func _on_wave_timer_timeout() -> void:
	print_debug("start wave")
	num_bullets = 0
	current_wave += 1
	bullet_timer.wait_time /= 1.5
	bullet_timer.start()
