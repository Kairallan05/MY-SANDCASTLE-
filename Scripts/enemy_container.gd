extends Node2D

var enemy = preload("uid://cdm8ylx03a1me")
@onready var spawn_timer: Timer = $"../Spawn_timer"
var health : float
var speed : float
var Score : float
func _ready() -> void:
	spawn_timer.start()
	health = 5.0
	speed = 15.0

func _on_spawn_timer_timeout() -> void:
	var x = randi_range(309, 875)
	while x > 475 and x < 700:
		x = randi_range(309, 875)
	var y = randi_range(117, 555)
	while y > 250 and y < 450:
		y = randi_range(309, 875)
	var new_enemy = enemy.instantiate()
	new_enemy.health = health
	new_enemy.speed = speed
	Score = health + speed
	new_enemy.score = Score
	add_child(new_enemy)
	new_enemy.global_position = Vector2(x, y)
	if spawn_timer.wait_time > 3.0:
		spawn_timer.wait_time -= 0.2
	elif spawn_timer.wait_time > 2.0:
		spawn_timer.wait_time -= 0.1
	elif spawn_timer.wait_time > 1.0:
		spawn_timer.wait_time -= 0.05
	elif spawn_timer.wait_time > 0.4:
		spawn_timer.wait_time -= 0.025
	health += 0.2
	speed += 0.02
