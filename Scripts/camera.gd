extends Camera2D

@onready var sand_castle: Area2D = $"../../SandCastle"

func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	if sand_castle.Castle_Health > 0.0:
		zoom = zoom.move_toward(Vector2(4,4), delta)


func _on_camzoomtimer_timeout() -> void:
	zoom = Vector2(4.05,4.05)
