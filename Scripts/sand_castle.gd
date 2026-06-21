extends Area2D

var Castle_Health = 100.0

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Castle_Health -= body.damage
		print(Castle_Health)
		body.queue_free()
