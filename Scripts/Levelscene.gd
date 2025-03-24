extends Node2D
@onready var createDust = $AnimatedSpriteDust
@onready var createThrust = $AnimatedSpriteThrust
@export var  thisLevelNbr :int
var switch = []
var t = 0
#@onready var blades = $Blades
var json_string
var json_result
signal trigger_blades
var json_levels = {
		"Level_1": {
			"Scenerios": {
				"One": {
					"Switch": [1]
				},
				"Two": {
					"Switch": [2, 4]
				}
			},
			"Action": {
				"One": {
					"nidle": [1]
				},
				"Two": {
					"nidle": [2]
				}
			}
		}
	}
func _ready() -> void:
	createThrust.visible = false
	createDust.visible = false
	GameManager.current_level = thisLevelNbr
	json_string = """{
		"Level_1": {
			"Scenerios": {
				"One": {
					"Switch": [1]
				},
				"Two": {
					"Switch": [2, 4]
				}
			},
			"Action": {
				"One": {
					"nidle": [1]
				},
				"Two": {
					"nidle": [2]
				}
			}
		}
	}"""
	
	var json = JSON.new()
	json_result = json.parse(json_string)

	var data = json.get_data()
	read_json_elements(data)
	


func read_json_elements(data, prefix: String = ""):
	if typeof(data) == TYPE_DICTIONARY:
		for key in data.keys():
			read_json_elements(data[key], prefix + str(key) + ".")
	elif typeof(data) == TYPE_ARRAY:
		for i in range(data.size()):
			read_json_elements(data[i], prefix + "[" + str(i) + "].")
	else:
		for i in switch:
			if data == i and "Scenerios.One.Switch" in prefix.trim_suffix("."):
				emit_signal("trigger_blades")
		print(prefix.trim_suffix("."), ":", data)

func _process(delta: float) -> void:
	pass

func _on_hero_jump_position_bust(position1) -> void: #signal connect from hero scene for jump dust animation
	createDust.position.x = position1.x
	createDust.position.y = position1.y-2
	createDust.visible = true
	createDust.play()

func _on_animated_sprite_dust_animation_finished() -> void: #stop dust animation
	createDust.visible = false
	if createDust.animation == "dust":
		createDust.stop()

func _on_hero_move_back_position(position2,rotation2) -> void: #signal connect from hero scene for thrust animation
	createThrust.visible = true
	createThrust.rotation = rotation2
	createThrust.position.x = position2.x
	createThrust.position.y = position2.y
	createThrust.play()

func _on_animated_sprite_thrust_animation_finished() -> void: #stop thrust animation
	createThrust.visible = false
	if createThrust.animation == "thrust":
		createThrust.stop()


func _on_switch_area_entered(area: Area2D) -> void:
	switch.append(1)
