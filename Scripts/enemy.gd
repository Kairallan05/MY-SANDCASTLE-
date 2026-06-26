extends CharacterBody2D
class_name Enemy

@onready var player: CharacterBody2D = $"../../Player"
@onready var sand_castle: Area2D = $"../../SandCastle"
@onready var hitable = false
@onready var healthbar: ProgressBar = $Healthbar
@onready var impact: AudioStreamPlayer2D = $Impact
@onready var death_timer: Timer = $Death_timer

var health = 10.0
var speed = 20.0
var damage = 5.0
var target
var dead

func _ready() -> void:
	healthbar.max_value = health
	target = sand_castle
	dead = false

func _physics_process(delta: float) -> void:
	healthbar.value = health

	var direction = (target.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, delta * (speed * 5))
	
	if health <= 0.0 and !dead:
		impact.play()
		death_timer.start()
		dead = true
	
	move_and_slide()

func _knockback(knockback : float):
	var direction = (player.global_position - global_position).normalized()
	velocity -= direction.normalized() * knockback

func _on_death_timer_timeout() -> void:
	queue_free()
