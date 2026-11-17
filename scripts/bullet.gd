extends Area3D

var velocity: Vector3

func initialize_variables(init_position: Vector3, init_velocity: Vector3):
	velocity = init_velocity
	position = init_position

func _process(delta: float) -> void:
	position += velocity * delta

func _on_destruction_timer_timeout() -> void:
	queue_free()
