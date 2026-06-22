extends Area2D

@onready var healthbar: ProgressBar = $Healthbar

var Castle_Health = 100.0

func _ready() -> void:
	healthbar.max_value = Castle_Health

func _process(delta: float) -> void:
	healthbar.value = Castle_Health

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Castle_Health -= body.damage
		print(Castle_Health)
		body.queue_free()
