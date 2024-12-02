extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_button_back_pressed() -> void:
	if FileAccess.file_exists("res://Scenes/landing_screen.tscn"): #check if file exsist or not
		get_tree().change_scene_to_file("res://Scenes/landing_screen.tscn") #go back to main screen


func _on_texture_button_about_pressed() -> void: #open info how to play game
	$ColorRect2.visible = true



func _on_touch_screen_button_released() -> void: #create touch button with big size and zero  visibility to close howtoplay
	$ColorRect2.visible = false


func _on_texture_button_music_pressed() -> void: #to stop pusic but  not working yet
	AudioController.background_play = true
	#AudioController.BackMusic.stop()
