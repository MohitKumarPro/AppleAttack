extends Area2D
@onready var blades = $AnimatedSprite2D
@export var bladeType:String
var blades_run = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$CollisionShape2D.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if blades_run == true:
		blades.play("blades")
	if blades.frame >= 17 and blades.frame <= 27:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true
		


func _on_level_2_trigger_blades() -> void:
	blades_run = true
