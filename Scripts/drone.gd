extends Ability

@onready var Hit_array: Array[CharacterBody2D]
@onready var range: Area2D = $Range
@onready var hitbox: Area2D = $Hitbox
@onready var sprite: Sprite2D = $Hitbox/Sprite
@onready var col: CollisionShape2D = $Range/Col
@onready var hit: CollisionShape2D = $Hitbox/Hit
@onready var player: CharacterBody2D = $"../.."

var damage : float
var new_target = true
var target : CharacterBody2D

func _ready() -> void:
	col.disabled = true
	hit.disabled = true
	damage = 10.0

func _process(delta: float) -> void:
	match stage:
		0:
			pass
		1:
			_stage1(delta)
		2:
			_stage2(delta)
		3:
			_stage3(delta)

func _stage1(delta):
	sprite.visible = true
	col.disabled = false
	hit.disabled = false
	Tutor_string = "SUPER ADVANCED TARGETING DRONE... 
	just get close to an enemy, 
	this will finish the job"
	for i in range(Hit_array.size() - 1, -1, -1):
		if !is_instance_valid(Hit_array[i]):
			Hit_array.remove_at(i)

	if Hit_array.is_empty():
		return

	if new_target or !is_instance_valid(target):
		target = Hit_array.pick_random()
		new_target = false

	hitbox.global_position = hitbox.global_position.move_toward(
		target.global_position,
		delta * 40
	)


func _stage2(delta):
	range.scale = Vector2(1.5, 1.5)
	damage = 15.0
	Tutor_string = "The drone can see further 
	and hits harder"
	for i in range(Hit_array.size() - 1, -1, -1):
		if !is_instance_valid(Hit_array[i]):
			Hit_array.remove_at(i)

	if Hit_array.is_empty():
		return

	if new_target or !is_instance_valid(target):
		target = Hit_array.pick_random()
		new_target = false

	hitbox.global_position = hitbox.global_position.move_toward(
		target.global_position,
		delta * 80
	)


func _stage3(delta):
	range.scale = Vector2(2.0, 2.0)
	damage = 30.0
	Tutor_string = "Even bigger range, 
	even better damage... 
	i swear"
	for i in range(Hit_array.size() - 1, -1, -1):
		if !is_instance_valid(Hit_array[i]):
			Hit_array.remove_at(i)

	if Hit_array.is_empty():
		return

	if new_target or !is_instance_valid(target):
		target = Hit_array.pick_random()
		new_target = false

	hitbox.global_position = hitbox.global_position.move_toward(
		target.global_position,
		delta * 120
	)


func _on_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Hit_array.append(body)


func _on_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Hit_array.erase(body)


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var sound = randf_range(0.5,1.5)
		body.impact.pitch_scale = sound
		body.impact.play()
		body.health -= damage
		target = player


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		new_target = true
