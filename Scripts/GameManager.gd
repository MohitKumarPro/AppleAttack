extends Node
var json = JSON.new()
var path = 'user://data.json'
var data
var current_level
var save_json = { #default json string when play first time
	1:{
		"level":1,
		"starts":1,
		"status":1,
	},
}

func add_json(Level, Stars, Status ,save_json): #can be called from anywhere to added level data in json
	var hasItem = false
	for i in save_json: #check if the level  already saved
		if save_json[str(i)]["level"] == Level:
			hasItem = true
	if hasItem == false: 
		save_json[str(save_json.size()+1)] = { #adding data to open next level
			"level":Level,
			"starts":Stars,
			"status":Status,
		}
	saveGame(save_json)
	loadGame()
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	#saveGame(save_json)
	data = loadGame() #runs and load the game data 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func saveGame(content):#write the game data and level info
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close
	file = null

func loadGame():#loads data immediaately after writing
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var content = json.parse_string(file.get_as_text())
		return content
	else:
		return save_json
	
	
