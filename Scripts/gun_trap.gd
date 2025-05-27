extends Node2D

@onready var gunAnitrap = $AnimatedSprite2D
@onready var gunAniRay = $AnimatedSprite2D/RayCast2D
var shoot_open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if gunAniRay.is_colliding():
		if gunAniRay:
			if gunAniRay.get_collider().name == "Area2D":
				shoot_open = true
	
	if shoot_open==true:
		gunAnitrap.play("fire")
	else:
		gunAnitrap.stop()


func _on_animated_sprite_2d_animation_finished() -> void:
	shoot_open = false
	gunAnitrap.stop()
