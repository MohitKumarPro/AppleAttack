extends CanvasLayer

var Music_pressed = preload("res://Assets/UI/sound_off.png")
var Music_normal = preload("res://Assets/UI/sound.png")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ColorRect2.visible = false
	if AudioController.background_play == true: #  this if else is to keep the music button status as it is
		$ColorRect/TextureButtonMusic.texture_normal = Music_normal
		$ColorRect/TextureButtonMusic.texture_pressed = Music_pressed
	else:
		$ColorRect/TextureButtonMusic.texture_normal = Music_pressed
		$ColorRect/TextureButtonMusic.texture_pressed = Music_normal


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


func _on_texture_button_music_pressed() -> void: #to stop the music and change the button texture when clicked
	if AudioController.background_play == false:
		AudioController.background_play = true 
		$ColorRect/TextureButtonMusic.texture_normal = Music_normal
		$ColorRect/TextureButtonMusic.texture_pressed = Music_pressed
	else:
		AudioController.background_play = false
		$ColorRect/TextureButtonMusic.texture_normal = Music_pressed
		$ColorRect/TextureButtonMusic.texture_pressed = Music_normal
		
	#AudioController.BackMusic.stop()
