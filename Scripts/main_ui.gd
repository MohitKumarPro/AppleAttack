extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_text_button_pressed() -> void:
	get_tree().paused = false
	self.hide()


func _on_restart_text_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_button_pressed() -> void:
	get_tree().paused = true
	self.show()
	


func _on_menu_text_button_pressed() -> void:
	get_tree().paused = false
	if FileAccess.file_exists("res://Scenes/landing_screen.tscn"): #check if file exsist or not
		get_tree().change_scene_to_file("res://Scenes/landing_screen.tscn")
