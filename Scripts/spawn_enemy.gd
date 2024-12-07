extends Node
#this script is used to  spawn enemies in mainn screen 
@export var enemyCount:int #total number of  enemies in scene

const enemyDoctor = preload("res://Scenes/Enemy.tscn")
@export var numbers: Array[Vector2]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(0,len(numbers)):
		var enemyDoctorSpawn =  enemyDoctor.instantiate() #initiate enemy scene
		enemyDoctorSpawn.position = numbers[i] #position of enemy
		get_parent().add_child.call_deferred(enemyDoctorSpawn) #create in  the sccene
		enemyDoctorSpawn.call_deferred("add_to_group", "enemies") #adding new spawn enemy in enemies group 
		enemyDoctorSpawn.currentEnemyCount.connect(_on_enemy_current_enemy_count) #adding signal sent to spawner to reduce counnt of enemies 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if enemyCount <= 0: #call game over  when no enemies in scene
		GameManager.add_json(GameManager.current_level+1, 1, 1, GameManager.data)
		if FileAccess.file_exists("res://Scenes/GameWin.tscn"): #check if file exsist or not
			get_tree().change_scene_to_file("res://Scenes/GameWin.tscn")


func _on_enemy_current_enemy_count() -> void: #signal sent from enemy node whenn enemy is  killed
	enemyCount = enemyCount-1
