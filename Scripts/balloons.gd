extends Ability

var LOON = preload("uid://qo6s3x20p10l").instantiate()

@onready var col: CollisionShape2D = $Range/Col
@onready var Hit_array: Array[CharacterBody2D]
@onready var timer: Timer = $Timer

var count
var time
var spawned = false

func _ready() -> void:
	col.disabled = true

func _process(delta: float) -> void:
	time = delta
	match stage:
		0:
			pass
		1:
			_stage1()
		2:
			_stage2()
		3:
			_stage3()

func _stage1():
	col.disabled = false
	if !spawned:
		timer.start()
		spawned = true

func _stage2():
	pass

func _stage3():
	pass


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Hit_array.append(body)
		print("poop1")


func _on_timer_timeout() -> void:
	if !Hit_array.is_empty():
		if stage == 1:
			var bloon = LOON.instantiate()
			bloon.global_position = global_position
			var target = Hit_array.pick_random()
			
			bloon.global_position = bloon.global_position.move_toward(target.global_position,time * 4)
			print("poop2")
