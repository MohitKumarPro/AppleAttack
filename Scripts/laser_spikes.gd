extends Node2D

@onready var laserAni = $AnimatedSprite2D
@onready var AudioController = $"../AudioController"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play_every_10_seconds()

func play_every_10_seconds() -> void:
	while true:
		await get_tree().create_timer(10.0).timeout
		laserAni.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if laserAni.frame >= 3 and laserAni.frame <= 15:
		AudioController.spikes_play()
		$laserSpikesArea/CollisionShape2D.disabled = false
	else:
		$laserSpikesArea/CollisionShape2D.disabled = true


func _on_animated_sprite_2d_animation_finished() -> void:
	laserAni.stop()
