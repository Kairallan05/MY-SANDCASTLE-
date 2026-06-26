extends Ability

@onready var cloud: AnimatedSprite2D = $Cloud
@onready var col: CollisionShape2D = $Hitbox/Col
@onready var Hit_array: Array[CharacterBody2D]
@onready var hiss: AudioStreamPlayer2D = $Hiss
@onready var timer: Timer = $Timer

var damage : float
var spawned = false

func _ready() -> void:
	col.disabled = true
	cloud.visible = false

func _process(delta: float) -> void:
	match stage:
		0:
			pass
		1:
			_stage1()
		2:
			_stage2()
		3:
			_stage3()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Hit_array.append(body)
		body.health -= damage

func _stage1():
	if !spawned:
		timer.start()
		spawned = true
	cloud.play("Stage1")
	col.scale = Vector2(0.6,0.6)
	col.disabled = false
	cloud.visible = true
	damage = 1.0

func _stage2():
	cloud.play("Stage2")
	col.scale = Vector2(1.0,1.0)
	damage = 2.0
func _stage3():
	cloud.play("Stage3")
	col.scale = Vector2(1.8,1.8)
	damage = 4.0


func _on_timer_timeout() -> void:
	hiss.play()
	for enemy in Hit_array:
		if enemy.health - damage <= 0.0:
			Hit_array.erase(enemy)
			enemy.health -= damage
		else:
			enemy.health -= damage
		


func _on_hitbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Hit_array.erase(body)
