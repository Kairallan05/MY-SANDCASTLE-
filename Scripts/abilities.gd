extends Node2D

@onready var boomerang: Ability = $Boomerang
@onready var prop_hat: Ability = $Prop_hat
@onready var stink: Ability = $Stink
@onready var drone: Ability = $Drone
@onready var ding: AudioStreamPlayer2D = $"../../CanvasLayer/Control2/Wheel/Ding"
@onready var player: CharacterBody2D = $".."
@onready var wheel: AnimatedSprite2D = $"../../CanvasLayer/Control2/Wheel"
@onready var spin_timer: Timer = $"../../CanvasLayer/Control2/Wheel/Spin_timer"
@onready var ability_array: Array[Ability] = [boomerang,prop_hat,stink,drone]
@onready var spin_meter: ProgressBar = $"../../CanvasLayer/Control/Spin_meter"


var paused = false
var spinning = false
var spin_speed = 0.02
var max_speed = 0.2
var spin = 0.0


func _process(delta: float) -> void:
	spin_meter.value = spin
	if spin >= 10.0:
		spin = 10.0
	else:
		spin += 0.01
	if Input.is_action_just_pressed("Pause") and spin == 10.0:
		get_tree().paused = true
		paused = true
		wheel.visible = true
		wheel.play("Idle")
	if Input.is_action_just_pressed("Spin") and paused:
		spinning = true
		spin_timer.start()
		var random = ability_array.pick_random()
		random._level()
		if random.stage == 3:
			ability_array.erase(random)
	
	if spinning:
		spin_speed = move_toward(spin_speed,max_speed,delta * spin_speed)
		wheel.rotation += spin_speed


func _on_spin_timer_timeout() -> void:
	wheel.play("Crumble")


func _on_wheel_animation_finished() -> void:
	get_tree().paused = false
	paused = false
	spinning = false
	spin = 0.0
	spin_speed = 0.04
	ding.play()
