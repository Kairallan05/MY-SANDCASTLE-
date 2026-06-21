extends CharacterBody2D
class_name Enemy

@onready var player: CharacterBody2D = $"../../Player"
@onready var hitable = false
@onready var healthbar: ProgressBar = $Healthbar
@onready var impact: AudioStreamPlayer2D = $Impact

var health = 10.0
var speed = 20.0

func _ready() -> void:
	healthbar.max_value = health

func _physics_process(delta: float) -> void:
	healthbar.value = health
	
	var direction = (player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, delta * speed)
	
	if health <= 0.0:
		queue_free()
	
	move_and_slide()

func _knockback(knockback : float):
	var direction = (player.global_position - global_position).normalized()
	velocity -= direction.normalized() * knockback
