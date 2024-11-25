extends CanvasLayer
@onready var gameOverScreenPlayer = $AnimationPlayer #animation player for zooming the game over and game win text

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextureRect.visible = false #make the text invisible when start the load of scene
	gameOverScreenPlayer.play("FadeStart") #start fade the color using animation player
	await gameOverScreenPlayer.animation_finished #wait for fade animation to completed
	$TextureRect.visible = true #make text visible before start zooming in
	gameOverScreenPlayer.play("ZoomIt") #zoomin the text message game over or game win


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
