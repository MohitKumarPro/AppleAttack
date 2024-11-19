extends Node2D
@onready var BackMusic = $Background
@onready var JumpMusic = $Jump
@onready var AtttackMusic = $Atttack
@onready var diveMusic = $dive
@onready var hitMusic = $Hit
var background_play = true
# Called when the node enters the scene tree for the first time.

func back_play():
	if background_play:
		print("play")
		BackMusic.play()

	
func attackplay():
	AtttackMusic.play()
	
func jumpplay():
	JumpMusic.play()


	
func hitplay():
	hitMusic.play()

	
func diveplay():
	diveMusic.play()
		
