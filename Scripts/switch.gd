extends Node2D
@onready var button = $Switch
@export var texture_path: String = "res://Assets/props/Dot_C.png"
var toggle_button = true
func _ready():
	# Load the texture dynamically from the exported path
	if texture_path != "":
		var texture: Texture2D = load(texture_path)
		
	

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Bullet":
		if toggle_button:
			toggle_button = !toggle_button
			button.texture = load("res://Assets/props/Dot_A.png")
		else:
			toggle_button = !toggle_button
			button.texture = load("res://Assets/props/Dot_C.png")
		
	
