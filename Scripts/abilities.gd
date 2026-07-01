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
@onready var control_4: Control = $"../../CanvasLayer/Control4"
@onready var tutor: Label = $"../../CanvasLayer/Control6/PanelContainer/Tutor"
@onready var click: AudioStreamPlayer2D = $"../../CanvasLayer/Control2/Wheel/Click"



var paused = false
var spinning = false
var spin_speed = 0.02
var max_speed = 0.2
var spin = 0.0
var spin_value = 10.0
var random : Ability


func _process(delta: float) -> void:
	if ability_array.is_empty():
		spin = 0.0
		
	spin_meter.value = spin
	spin_meter.max_value = spin_value
	if spin >= spin_value:
		spin = spin_value
	
	if spin == spin_value:
		get_tree().paused = true
		paused = true
		wheel.visible = true
		wheel.play("Idle")
		control_4.visible = true
	if Input.is_action_just_pressed("Spin") and paused and !spinning:
		spinning = true
		click.play()
		spin_timer.start()
		random = ability_array.pick_random()
		random._level()
		if random.stage == 3:
			ability_array.erase(random)
		spin_value += (spin_value * 0.5)
	
	if spinning:
		spin_speed = move_toward(spin_speed,max_speed,delta * spin_speed)
		wheel.rotation += spin_speed
	if random != null:
		tutor.text = random.Tutor_string


func _on_spin_timer_timeout() -> void:
	wheel.play("Crumble")


func _on_wheel_animation_finished() -> void:
	click.stop()
	get_tree().paused = false
	paused = false
	spinning = false
	spin = 0.0
	spin_speed = 0.04
	ding.play()
	control_4.visible = false
