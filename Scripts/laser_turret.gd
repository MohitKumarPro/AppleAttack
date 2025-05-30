extends Node2D

@onready var gunAnitrap = $AnimatedSprite2D
@onready var gunAniRay = $AnimatedSprite2D/RayCast2D
@onready var AudioController = $"../AudioController"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gunAnitrap.frame >= 5 and gunAnitrap.frame <= 13:
		AudioController.laser_play()
		$laserTurretArea/CollisionShape2D.disabled = false
		$Line2D.visible = true
	else:
		$laserTurretArea/CollisionShape2D.disabled = true
		$Line2D.visible = false
	if gunAniRay.is_colliding():
		if gunAniRay:
			if gunAniRay.get_collider().name == "Area2D":
				print("thisis")
				run_gun()

func run_gun():
	gunAnitrap.play()

func _on_animated_sprite_2d_animation_finished() -> void:
	gunAnitrap.stop()
