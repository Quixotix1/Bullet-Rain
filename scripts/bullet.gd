class_name Bullet

extends Area3D

@export var collider: CollisionShape3D
var velocity: Vector3

func _process(delta: float) -> void:
	position += velocity * delta

func _on_destruction_timer_timeout() -> void:
	BulletPool.add_to_pool(self)
