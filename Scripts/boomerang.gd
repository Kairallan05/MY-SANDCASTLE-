extends Ability

@onready var boomerang: Sprite2D = $Hitbox/Boomerang
@onready var col: CollisionShape2D = $Hitbox/Col
@onready var boomerang_2: Sprite2D = $Hitbox/Boomerang2
@onready var col_2: CollisionShape2D = $Hitbox/Col2

var knockback : float
var damage : float

func _ready() -> void:
	knockback = 40
	damage = 2.0
	

func _process(delta: float) -> void:
	match stage:
		0:
			pass
		1:
			_stage1()
		2:
			_stage2()

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
