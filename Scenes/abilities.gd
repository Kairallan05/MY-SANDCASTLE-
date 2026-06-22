extends Node2D

@onready var boomerang: Ability = $Boomerang
@onready var ding: AudioStreamPlayer2D = $"../Wheel/Ding"
@onready var player: CharacterBody2D = $".."
@onready var wheel: AnimatedSprite2D = $"../Wheel"
@onready var spin_timer: Timer = $"../Wheel/Spin_timer"

var paused = false
var spinning = false
var spin_speed = 0.01
var max_speed = 0.2

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		get_tree().paused = true
		paused = true
		wheel.visible = true
		wheel.play("Idle")
	if Input.is_action_just_pressed("Spin") and paused:
		spinning = true
		spin_timer.start()
		boomerang._level()
	
	if spinning:
		spin_speed = move_toward(spin_speed,max_speed,delta * spin_speed)
		wheel.rotation += spin_speed


func _on_spin_timer_timeout() -> void:
	wheel.play("Crumble")


func _on_wheel_animation_finished() -> void:
	get_tree().paused = false
	paused = false
	spinning = false
	spin_speed = 0.01
	ding.play()
