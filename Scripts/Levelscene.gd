extends Node2D
@onready var createDust = $AnimatedSpriteDust
@onready var createThrust = $AnimatedSpriteThrust

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	createThrust.visible = false
	createDust.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_hero_jump_position_bust(position1) -> void: #signal connect from hero scene for jump dust animation
	createDust.position.x = position1.x
	createDust.position.y = position1.y-2
	createDust.visible = true
	createDust.play()

func _on_animated_sprite_dust_animation_finished() -> void: #stop dust animation
	createDust.visible = false
	if createDust.animation == "dust":
		createDust.stop()

func _on_hero_move_back_position(position2,rotation2) -> void: #signal connect from hero scene for thrust animation
	createThrust.visible = true
	createThrust.rotation = rotation2
	createThrust.position.x = position2.x
	createThrust.position.y = position2.y
	createThrust.play()

func _on_animated_sprite_thrust_animation_finished() -> void: #stop thrust animation
	createThrust.visible = false
	if createThrust.animation == "thrust":
		createThrust.stop()
