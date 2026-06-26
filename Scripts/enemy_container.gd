extends Node2D

var enemy = preload("uid://cdm8ylx03a1me")
@onready var spawn_timer: Timer = $"../Spawn_timer"

func _ready() -> void:
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	var x = randi_range(309, 875)
	var y = randi_range(117, 555)
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.global_position = Vector2(x, y)
