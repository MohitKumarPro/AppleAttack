extends CharacterBody2D

signal currentEnemyCount
var SPEED = 50.0
var direction = Vector2(-1,0)#-1
var is_alive = true
var is_attack = false
@onready var animationEnemyFly = $AnimatedSprite2D
func _physics_process(delta: float) -> void:
	if is_alive:
		#direction = Vector2(-1,0)
		rotation_degrees = 0
		animationEnemyFly.play("run")
		velocity = direction * SPEED
	if is_attack:
		animationEnemyFly.play("Attack")
		rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction)+180)
		velocity = direction * 400
	move_and_slide()


func _on_enemy_area_2d_area_entered(area: Area2D) -> void:
	if animationEnemyFly and area.name == "Bullet":
		is_alive = false
		animationEnemyFly.play("Death")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animationEnemyFly.animation == "run":
		animationEnemyFly.stop()
	if animationEnemyFly.animation == "Death":
		animationEnemyFly.stop()
		emit_signal("currentEnemyCount")
		queue_free()


func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Hero":
		is_alive=false
		is_attack = true
		direction = (body.global_position-animationEnemyFly.global_position).normalized()
		await get_tree().create_timer(1).timeout
		is_alive=true
		is_attack = false
	
	if body.name != "Hero" and body.name != "Bullet":
		if animationEnemyFly.flip_h:
			animationEnemyFly.flip_h = false
			direction = Vector2(-1,0)
		else:
			animationEnemyFly.flip_h = true
			direction = Vector2(1,0)
	
	
