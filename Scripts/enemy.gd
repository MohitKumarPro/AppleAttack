extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animationEnemy = $AnimatedSprite2D
@onready var AudioController = $"../AudioController"
var is_alive = true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_alive:
		animationEnemy.play("Walk")
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


	
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	is_alive = false
	AudioController.hitplay()
	AudioController.diveplay()
	animationEnemy.play("Death")
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if animationEnemy.animation == "Walking":
		animationEnemy.stop()
	if animationEnemy.animation == "Death":
		animationEnemy.stop()
		queue_free()
	
