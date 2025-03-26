extends CharacterBody2D

var SPEED = 50.0
const JUMP_VELOCITY = -400.0
@onready var RayLine =  $RayCast2D
@onready var RayLine2 =  $RayCast2D2
@onready var RayLine3 =  $RayCast2D3
@onready var RayLine4 =  $RayCast2D4
@onready var animationEnemy = $AnimatedSprite2D
@onready var AudioController = $"../AudioController"
@onready var collshape = $AttackBack/CollisionShape2D
@onready var maker_2d2 = $Marker2D
@onready var maker_2d = $Marker2D2
const BULLET = preload("res://Scenes/bullet.tscn")
var direction
signal currentEnemyCount
var is_alive = true
var firstray = true
var secondray = true
var fourthray = true
var thirdray = true
var bulletDirection = Vector2(1,0)
func _ready():
	direction = -1
func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_alive:
		animationEnemy.play("Walk")
	var collider_RayLine3 = RayLine3.get_collider()
	var collider_RayLine4 = RayLine4.get_collider()
		
	if (!RayLine.is_colliding())  and  is_on_floor():
		firstray = false
		secondray = true
		if direction !=1:
			direction = 1
		if animationEnemy.flip_h != true:
			animationEnemy.flip_h = true
			animationEnemy.position.x = animationEnemy.position.x
			collshape.position.x = collshape.position.x+80
			maker_2d2.position.x = maker_2d2.position.x+140
			maker_2d.position.x = maker_2d.position.x+150
		
	
	if (!RayLine2.is_colliding())  and  is_on_floor():
		firstray = true
		secondray = false
		if direction !=-1:
			direction = -1
		if animationEnemy.flip_h != false:
			animationEnemy.flip_h = false
			animationEnemy.position.x = animationEnemy.position.x
			collshape.position.x = collshape.position.x-80
			maker_2d2.position.x = maker_2d2.position.x-140
			maker_2d.position.x = maker_2d.position.x-150
			
		
			
	if collider_RayLine3:
		if (RayLine3.is_colliding())  and collider_RayLine3.name !="Blades" and  is_on_floor():
			thirdray = false
			fourthray = true
			if direction !=1:
				direction = 1
			if animationEnemy.flip_h != true:
				animationEnemy.flip_h = true
				animationEnemy.position.x = animationEnemy.position.x
				collshape.position.x = collshape.position.x+80
				maker_2d2.position.x = maker_2d2.position.x+140
				maker_2d.position.x = maker_2d.position.x+150
				
	if collider_RayLine4:
		if (RayLine4.is_colliding())  and collider_RayLine4.name !="Blades"  and  is_on_floor():
			thirdray = true
			fourthray = false
			if direction !=-1:
				direction = -1
			if animationEnemy.flip_h != false:
				animationEnemy.flip_h = false
				animationEnemy.position.x = animationEnemy.position.x
				collshape.position.x = collshape.position.x-80
				maker_2d2.position.x = maker_2d2.position.x-140
				maker_2d.position.x = maker_2d.position.x-150
				
				
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if attackBack == true:
		#animationEnemy.play("attack")
	velocity.x = direction * SPEED
	move_and_slide()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name=="Bullet" or area.name.contains("Blades"):
		is_alive = false
		SPEED = 0
		AudioController.hitplay()
		AudioController.diveplay()
		animationEnemy.play("Death")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animationEnemy.animation == "attack":
		is_alive = true
		animationEnemy.stop()
	if animationEnemy.animation == "Walking":
		animationEnemy.stop()
	if animationEnemy.animation == "Death":
		animationEnemy.stop()
		emit_signal("currentEnemyCount")
		queue_free()


func _on_attack_back_area_entered(area: Area2D) -> void:
	if area.name =="Bullet":
		is_alive = false
		animationEnemy.stop()
		animationEnemy.play("attack")
		await get_tree().create_timer(0.3).timeout
		var bulletNode = BULLET.instantiate()
		bulletDirection = (maker_2d.global_position-maker_2d2.global_position).normalized()
		bulletNode.set_direction(bulletDirection)
		get_tree().root.add_child(bulletNode)
		bulletNode.global_position = maker_2d.global_position
