extends CharacterBody2D

@export var  appleCount:int #provide mnumber of apples to player 
@export var shootSpeed = 1.0

#bullet
@onready var line2 = $Line2D
@onready var maker_2d2 = $Marker2D
@onready var maker_2d = $Marker2D2
@onready var AudioController = $"../AudioController"
@onready var shoot_speed_timer = $shootSpeedTimer
@onready var flame = $AnimatedSpriteFlame
@onready var animationPlay = $AnimatedSprite2D

signal jumpPositionBust #send position to mainscreen gdscript for jump dust animation
signal moveBackPosition #send position to mainscreen gdscript  for jump thrust animation
signal applesCount #send the  number of apples available

const BULLET = preload("res://Scenes/bullet.tscn")
const JUMP_VELOCITY = -500.0
const ATTACK_DURATION = 0.5  # Example duration for the attack animation

var canShoot = true
var bulletDirection = Vector2(1,0)
var SPEED = 10
# Declare constants for attack settings
var is_attacking = false
var attack_timer = 0.0
# Variables to manage jump state
var is_jumping = false
var is_falling = false
var is_onfloor = true
var is_freez = true
var back_move = false
var rotation_speed = 2
var rotate_it = true
var air_jump = false
var ro_speed = 5
var shoot_ready = true



func _ready() -> void:
	AudioController.back_play()
	animationPlay.play("Ideal")
	shoot_speed_timer.wait_time = 1.0/ shootSpeed
	line2.visible = false
	emit_signal("applesCount",appleCount) #initialize count of  apple in canvas screenn

func shoot():
	if canShoot:
		canShoot = true
		shoot_speed_timer.start()
		
		var bulletNode = BULLET.instantiate()
		bulletDirection = (maker_2d.global_position-maker_2d2.global_position).normalized()
		bulletNode.set_direction(bulletDirection)
		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = maker_2d.global_position
	
	
func _physics_process(delta: float) -> void:
	
	
	if not is_on_floor() and is_freez:
		velocity += get_gravity()*0.5 * delta
		
	
	if Input.is_action_pressed("ui_down") and !is_on_floor() and shoot_ready:
		line2.visible = true
		is_onfloor = false
		is_jumping = false
		is_falling = false
		is_freez =  false
		rotate_it = false
		rotation += rotation_speed * delta
		velocity.y=50
	
	if Input.is_action_just_released("ui_down") and !is_on_floor() and shoot_ready:
		shoot_ready = false
		line2.visible = false
		air_jump = false
		animationPlay.play("Attack")
		await get_tree().create_timer(0.4).timeout
		AudioController.attackplay()
		shoot()
		back_move = true
		await get_tree().create_timer(0.5).timeout
		back_move = false
		shoot_ready = true
		is_freez =  true
		rotate_it = true
		air_jump = true
		appleCount = appleCount - 1 #reduce count of apple in each through
		emit_signal("applesCount",appleCount) #emit signal to reduce count of apples in canvas screen 

	if !is_on_floor() and rotate_it:
		animationPlay.offset =Vector2(0,-25)
		rotation += ro_speed * delta

	if back_move:
		emit_signal("moveBackPosition",position,rotation) ##send signal to mainscript to creat thrust in sky
		move_and_collide(-1*(maker_2d.global_position-maker_2d2.global_position).normalized()*SPEED)
		
		
		
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		is_onfloor = true
		is_jumping = false
		is_falling = false
	# Handle jump start
	if Input.is_action_just_pressed("ui_up") and is_on_floor() and is_onfloor:
		is_onfloor = false
		velocity.y = JUMP_VELOCITY
		AudioController.jumpplay()
		#animationPlayDust.visible =true
		#animationPlayDust.play("dust")
		#animationPlay.play("JumpUp")
		emit_signal("jumpPositionBust",position) #send signal to mainscript to creat dust on ground
		
	if is_on_floor():
		is_falling = true
		line2.visible = false
		is_freez = true
		is_onfloor = true
		is_onfloor = false
		rotate_it = true
		
		
	if is_falling and is_on_floor():
		
		while int(rotation) !=0:
			await get_tree().create_timer(0.1).timeout
			if int(rotation) <0:
				rotation += 0.01
			else:
				rotation -= 0.01
		rotation = 0
		flame.visible = false
		flame.stop()
		animationPlay.play("JumpDown")

	if air_jump and !is_on_floor():
		animationPlay.play("JumpUp")
	
	# Transition to Idle when landing on the floor
	if is_on_floor() and is_jumping:
		animationPlay.play("Ideal")
			
	if !is_on_floor():
		flame.visible = true
		flame.play()
	
	if appleCount <= 0:
		if FileAccess.file_exists("res://Scenes/GameOver.tscn"): #check if file exsist or not
			get_tree().change_scene_to_file("res://Scenes/GameOver.tscn")

	move_and_slide()
	
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if animationPlay.animation == "JumpDown":
		is_falling = false
		is_jumping = true
		is_onfloor = false
		animationPlay.stop()
	if animationPlay.animation == "JumpUp":
		animationPlay.stop()
		is_falling = true
		is_jumping = false
		is_onfloor = false
	if animationPlay.animation == "Ideal":
		animationPlay.stop()
		is_falling = false
		is_jumping = true
		is_onfloor = true
		
	if animationPlay.animation == "Attack":
		animationPlay.stop()
		if is_on_floor():
			is_falling = false
			is_jumping = true
			is_onfloor = true
		else:
			is_falling = true
			is_jumping = false
			is_onfloor = false
			air_jump = true


func _on_shoot_speed_timer_timeout() -> void:
	canShoot=true
