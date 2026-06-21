extends CharacterBody2D

@onready var camera: Camera2D = $Camera
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var arm: Node2D = $Arm
@onready var melee_sprite: AnimatedSprite2D = $Arm/Melee_Sprite
@onready var melee_timer: Timer = $Arm/Melee_timer
@onready var melee_col: Area2D = $Arm/Melee_Col

@export var speed = 150.0
@export var knockback = 30.0

var attacking = false


func _ready() -> void:
	melee_sprite.play("Idle")

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
	
	camera.offset = camera.offset.move_toward((direction * 10),delta * 50.0)
	
	if direction:
		sprite.play("Walk")
	else:
		sprite.play("Idle")
	
	_melee()
	
	move_and_slide()

func _melee() -> void:
	arm.look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("attack") and !attacking:
		attacking = true
		melee_col.monitoring = true
		melee_col.monitorable = true
		melee_sprite.play("Attack")
		melee_timer.start()

func _on_melee_sprite_animation_finished() -> void:
	melee_sprite.play("Idle")
	melee_col.monitoring = false
	melee_col.monitorable = false

func _on_melee_timer_timeout() -> void:
	attacking = false

func _on_melee_col_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		body.impact.play()
		body._knockback(knockback)
		body.health -= 1.0
