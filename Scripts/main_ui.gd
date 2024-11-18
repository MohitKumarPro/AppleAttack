extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("thisis a testing code")
	pass




func _on_menu_button_pressed() -> void:
	print("called")
	self.show()


func _on_close_text_button_pressed() -> void:
	self.hide()


func _on_restart_text_button_pressed() -> void:
	get_tree().reload_current_scene()
