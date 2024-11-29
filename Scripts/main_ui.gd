extends CanvasLayer
@onready var grid_container = $Control/HBoxContainer
var num_grids = 1
var current_grid = 1
var grid_width = 881
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	num_grids = grid_container.get_child_count() #number of grid in hbox container each grid have textbutton in it
	grid_width = grid_container.custom_minimum_size.x #length of grid to calculate which part of the grid is visible to screen
	setup_level_box() #add number and state(locked or unlocked) to button
	connect_level_select_to_level_box() #connect to signal emit by each button and change to that scene

func connect_level_select_to_level_box():
	for grid in grid_container.get_children(): #get number of grid in hbox
		for box in grid.get_children(): #get number of buttons in grid
			box.connect("level_selected",change_to_scene) # connect to level_selected signal emit by button scene
	
func change_to_scene(level_num: int):
	var next_level: String = "res://Levels/Level" + str(level_num) + ".tscn" #path of the level file
	if FileAccess.file_exists(next_level): #check if file exsist or not
		get_tree().change_scene_to_file(next_level) #change the  scene of button press on canvas screen

func setup_level_box():
	for grid in grid_container.get_children(): #get number of grid in hbox
		for box in grid.get_children(): #get number of buttons in grid
			box.level_num = box.get_index() + 1 + grid.get_child_count() * grid.get_index() #assign number to the button
			box.locked = true #state of the button
	grid_container.get_child(0).get_child(0).locked = false #first button set to unlock




func _on_menu_button_pressed() -> void: #menu button on each screen to hide or chow canvas
	self.show()


func _on_close_text_button_pressed() -> void: #close button on canvas screen to close the levelselect canvas
	self.hide()


func _on_restart_text_button_pressed() -> void: #restart button on canvas screen to reload the current scene
	get_tree().reload_current_scene()


func _on_left_text_button_pressed() -> void: #left  button on levelselec canvas to scroll to right
	if current_grid > 1: 
		current_grid -=1
		animateGridPosition(grid_container.position.x+grid_width)

func _on_right_text_button_pressed() -> void: #right  button on levelselec canvas to scroll to left
	if current_grid < num_grids:
		current_grid +=1
		animateGridPosition(grid_container.position.x-grid_width)

func animateGridPosition(finalValue):
	create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).tween_property(
		grid_container,"position:x",finalValue, 0.5
	)
