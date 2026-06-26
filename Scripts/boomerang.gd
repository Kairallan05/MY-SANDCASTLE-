extends Ability

@onready var boomerang: Sprite2D = $Hitbox/Boomerang
@onready var col: CollisionShape2D = $Hitbox/Col
@onready var boomerang_2: Sprite2D = $Hitbox/Boomerang2
@onready var col_2: CollisionShape2D = $Hitbox/Col2

var knockback : float
var damage : float

func _ready() -> void:
	knockback = 40
	damage = 8.0
	

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
		body.impact.play()
		body._knockback(knockback)
		body.health -= damage

func _stage1():
	boomerang.visible = true
	col.disabled = false
	boomerang.rotation += 0.1
	rotation += 0.05

func _stage2():
	boomerang.visible = true
	col.disabled = false
	boomerang_2.visible = true
	col_2.disabled = false
	boomerang.rotation += 0.1
	boomerang_2.rotation += 0.1
	rotation += 0.05
	knockback = 50
	damage = 3.0

func _stage3():
	boomerang.texture = preload("uid://dipqvj58jb7ah")
	boomerang_2.texture = preload("uid://dipqvj58jb7ah")
	col.scale.x = 1.5
	col.scale.y = 1.5
	boomerang.visible = true
	col.disabled = false
	boomerang_2.visible = true
	col_2.disabled = false
	boomerang.rotation += 0.1
	boomerang_2.rotation += 0.1
	rotation += 0.075
	knockback = 75
	damage = 5.0
