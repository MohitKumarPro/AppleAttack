extends Area2D

@export var speed = 10
@export var damage = 15
			  # Friction to simulate drag
var direction:Vector2
func _ready() -> void:
	await get_tree().create_timer(3).timeout
	queue_free()
func set_direction(bulletDirection):
	direction =  bulletDirection
	rotation_degrees = rad_to_deg(global_position.angle_to_point(global_position+direction))

func _physics_process(delta):
	global_position += direction * speed
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name=='AttackBack': #for EnemyDoc stop bullet to hit from front
		queue_free()
		
