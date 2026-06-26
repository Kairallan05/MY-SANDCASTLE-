extends Ability

@onready var col: CollisionShape2D = $Hitbox/Col
@onready var hat: Sprite2D = $Hat


var knockback : float
var damage : float

func _ready() -> void:
	col.disabled = true
	hat.visible = false
	knockback = 30
	damage = 2.0
	

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
	col.disabled = false
	hat.visible = true
	knockback = 30
	damage = 2.0

func _stage2():
	knockback = 40
	damage = 3.0
func _stage3():
	knockback = 60
	damage = 5.0
