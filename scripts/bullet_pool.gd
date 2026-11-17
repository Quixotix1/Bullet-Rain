extends Node

var bullet_scene: PackedScene = preload("uid://d22uk0p3phqjq")
var pool: Array[Bullet] = []

func add_to_pool(object: Node3D) -> void:
	pool.append(object)
	object.set_process(false)
	object.set_physics_process(false)
	object.collider.disabled = true
	object.hide()

func pull_from_pool() -> Node3D:
	var object: Bullet
	if pool.is_empty():
		object = bullet_scene.instantiate()
		add_child(object)
	else:
		object = pool.pop_back()
	object.collider.disabled = false
	object.set_process(true)
	object.set_physics_process(true)
	object.show()
	return object
