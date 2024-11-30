extends CanvasLayer

var levelMenu = "res://Scenes/grid_levelscene.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_texture_button_play_pressed() -> void:
	if FileAccess.file_exists(levelMenu): #check if file exsist or not
		get_tree().change_scene_to_file(levelMenu) #change the  scene of button press on canvas screen
