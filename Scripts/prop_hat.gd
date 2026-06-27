extends Ability

@onready var col: CollisionShape2D = $Hitbox/Col
@onready var hat: Sprite2D = $Hat


var knockback : float
var damage : float

func _ready() -> void:
	col.disabled = true
	hat.visible = false
	knockback = 30
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
		var sound = randf_range(0.5,1.5)
		body.impact.pitch_scale = sound
		body.impact.play()
		body._knockback(knockback)
		body.health -= damage

func _stage1():
	col.disabled = false
	hat.visible = true
	knockback = 30
	damage = 15.0
	Tutor_string = "You get a hat, it seems familiar 
	(Walk into enemies to use)"

func _stage2():
	knockback = 50
	damage = 30.0
	Tutor_string = "Propeller hat used harden, 
	you can headbutt harder"
func _stage3():
	knockback = 200
	damage = 60.0
	Tutor_string = "DAMN YOUR LIKE A BATTERING RAM 
	(knockback and damage increased further)"
