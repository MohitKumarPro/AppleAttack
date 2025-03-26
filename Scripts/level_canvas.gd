extends CanvasLayer

@onready var AppleLable = $TextureRect/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_hero_apples_count(appleeCount) -> void: #signal sent from _ready and each time count reduces of hero to initialize the count of apples
	$TextureRect/Label.text = str(appleeCount) 


func _on_hero_lifecount(lifes) -> void:
	$TextureRectLife/Label.text = str(lifes) 
