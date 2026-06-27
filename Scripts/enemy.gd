extends CharacterBody2D
class_name Enemy

@onready var player: CharacterBody2D = $"../../Player"
@onready var sand_castle: Area2D = $"../../SandCastle"
@onready var hitable = false
@onready var healthbar: ProgressBar = $Healthbar
@onready var impact: AudioStreamPlayer2D = $Impact
@onready var death_timer: Timer = $Death_timer
@onready var abilities: Node2D = $"../../Player/Abilities"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var death: AudioStreamPlayer2D = $Death


var health : float
var speed : float
var damage = 5.0
var target
var dead
var score : float

func _ready() -> void:
	animated_sprite_2d.play("Walk")
	healthbar.max_value = health
	target = sand_castle
	dead = false

func _physics_process(delta: float) -> void:
	healthbar.value = health
	if !dead:
		var direction = (target.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * speed, delta * (speed * 5))
	
	if health <= 0.0 and !dead:
		var sound = randf_range(0.5,1.5)
		death.pitch_scale = sound
		death.play()
		animated_sprite_2d.play("Dead")
		death_timer.start()
		dead = true
	
	move_and_slide()

func _knockback(knockback : float):
	var direction = (player.global_position - global_position).normalized()
	velocity -= direction.normalized() * knockback

func _on_death_timer_timeout() -> void:
	abilities.spin += 2.5
	player.Score += score
	queue_free()
