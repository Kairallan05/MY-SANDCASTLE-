extends CharacterBody2D
class_name Enemy

@onready var player: CharacterBody2D = $"../../Player"
@onready var hitable = false

func _physics_process(delta: float) -> void:
	
	global_position = global_position.move_toward(player.global_position, delta * 10)
	
	move_and_slide()
