extends Area2D

@onready var pop: AudioStreamPlayer2D = $pop
@onready var splash: AnimatedSprite2D = $Splash

var knockback : float
var damage : float
var target : CharacterBody2D

func _ready() -> void:
	knockback = 60.0
	damage = 5.0

func _process(delta: float) -> void:
	rotation += 0.05
	if is_instance_valid(target):
		global_position.move_toward(target.global_position,delta * 800)
	else:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.impact.play()
		pop.play()
		splash.visible = true
		splash.play("Splash")
		body._knockback(knockback)
		body.health -= damage

func _on_splash_animation_finished() -> void:
	queue_free()
