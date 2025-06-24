extends Node2D
@onready var AudioController = $"../AudioController"
@onready var laserAni = $AnimatedSprite2D
@export var move_saw_time = 10
@export var movement_time_saw = 1000
@export var speed := 100.0  # pixels per second
@export var direction := 1  # 1 for right, -1 for left
@export var horizon = 'H'
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_every_10_seconds()
	run_cycle()

func play_every_10_seconds() -> void:
	while true:
		await get_tree().create_timer(move_saw_time).timeout
		AudioController.saw_play()
		laserAni.play()

func run_cycle() -> void:
	while true:
		var start_time := Time.get_ticks_msec()
		var now := start_time
		while (now - start_time) < movement_time_saw:
			var prev_time := now
			if get_tree() == null:
				return
			await get_tree().process_frame
			now = Time.get_ticks_msec()
			var delta = float(now - prev_time) / 1000.0
			if horizon == 'H':
				position.x += speed * delta * direction
			else:
				position.y += speed * delta * direction
		if get_tree() == null:
			return
		await get_tree().create_timer(5.0).timeout
		direction *= -1

func _process(delta: float) -> void:
	if laserAni.frame >= 4 and laserAni.frame <= 38:
		$sawRunArea/CollisionShape2D.disabled = false
	else:
		$sawRunArea/CollisionShape2D.disabled = true


func _on_animated_sprite_2d_animation_finished() -> void:
	laserAni.stop()
