extends CanvasLayer
@onready var grid_container = $Control/HBoxContainer
var num_grids = 1
var current_grid = 1
var grid_width = 881
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	num_grids = grid_container.get_child_count()
	grid_width = grid_container.custom_minimum_size.x






func _on_menu_button_pressed() -> void:
	self.show()


func _on_close_text_button_pressed() -> void:
	self.hide()


func _on_restart_text_button_pressed() -> void:
	get_tree().reload_current_scene()


func _on_left_text_button_pressed() -> void:
	if current_grid > 1:
		current_grid -=1
		animateGridPosition(grid_container.position.x+grid_width)

func _on_right_text_button_pressed() -> void:
	if current_grid < num_grids:
		current_grid +=1
		animateGridPosition(grid_container.position.x-grid_width)

func animateGridPosition(finalValue):
	create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).tween_property(
		grid_container,"position:x",finalValue, 1.5
	)


func _on_texture_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/Level1.tscn")
