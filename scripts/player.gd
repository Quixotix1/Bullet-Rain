class_name Player

extends CharacterBody3D

@export var normal_speed = 5.0
@export var slow_speed = 1.0
@export var max_health = 10.0

var speed
var health

func _ready() -> void:
	speed = normal_speed
	health = max_health
	EventBus.hit_player.connect(_on_hit_player)
	EventBus.game_over.connect(_kill)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("slowdown"):
		speed = slow_speed
	if Input.is_action_just_released("slowdown"):
		speed = normal_speed
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	velocity = Vector3(input_dir.x, 0, input_dir.y).normalized() * speed
	move_and_slide()

func _on_hit_player():
	health -= 1.0
	if health <= 0.0:
		EventBus.game_over.emit()
	EventBus.update_ui.emit()

func _kill():
	hide()
	set_process(false)
	set_physics_process(false)

func _on_hit_collider_area_entered(area: Area3D) -> void:
	EventBus.hit_player.emit()
