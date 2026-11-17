extends ProgressBar

@export var player: Player

func _ready() -> void:
	if player == null:
		player = get_tree().get_first_node_in_group("Player")
	max_value = player.max_health
	value = max_value
	EventBus.update_ui.connect(_update_health)

func _update_health() -> void:
	value = player.health
