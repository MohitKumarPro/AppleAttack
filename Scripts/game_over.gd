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


func _on_texture_button_menu_pressed() -> void:
	if FileAccess.file_exists("res://Scenes/landing_screen.tscn"): #check if file exsist or not
		get_tree().change_scene_to_file("res://Scenes/landing_screen.tscn")


func _on_texture_button_restart_pressed() -> void:
	get_tree().paused = false
	var current_level: String = "res://Levels/Level" + str(GameManager.current_level) + ".tscn" #path of the level file
	if FileAccess.file_exists(current_level): #check if file exsist or not
		get_tree().change_scene_to_file(current_level)


func _on_texture_button_next_pressed() -> void:
	get_tree().paused = false
	var next_level: String = "res://Levels/Level" + str(GameManager.current_level+1) + ".tscn" #path of the level file
	if FileAccess.file_exists(next_level): #check if file exsist or not
		get_tree().change_scene_to_file(next_level)
