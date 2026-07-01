extends Area2D

@onready var healthbar: ProgressBar = $Healthbar
@onready var control_5: Control = $"../CanvasLayer/Control5"
@onready var music: AudioStreamPlayer2D = $"../Player/Music"
@onready var deathmusic: AudioStreamPlayer2D = $"../Player/Deathmusic"
@onready var hit: AudioStreamPlayer2D = $Hit

var Castle_Health = 100.0

func _ready() -> void:
	healthbar.max_value = Castle_Health

func _process(delta: float) -> void:
	healthbar.value = Castle_Health
	
	if Castle_Health <= 0.0:
		get_tree().paused = true
		control_5.visible = true
		music.stop()
		if !deathmusic.playing:
			deathmusic.play()
		if Input.is_action_pressed("Pause"):
			get_tree().paused = false
			get_tree().reload_current_scene()
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		Castle_Health -= body.damage
		hit.play()
		body.queue_free()
