extends Node2D
@onready var BackMusic = $Background
@onready var JumpMusic = $Jump
@onready var AtttackMusic = $Atttack
@onready var diveMusic = $dive
@onready var hitMusic = $Hit
@onready var sawplay = $saw_run_play
@onready var laserplay = $laser_gun_play
@onready var spikesPlay = $spikes_gun_play
@onready var bladesPlay = $blades_play
var background_play = true
# Called when the node enters the scene tree for the first time.

func back_play():
	if AudioController.background_play == true:
		BackMusic.play()

	
func attackplay():
	AtttackMusic.play()
	
func jumpplay():
	JumpMusic.play()


	
func hitplay():
	hitMusic.play()

	
func diveplay():
	diveMusic.play()

func saw_play():
	sawplay.play()

func laser_play():
	laserplay.play()
	
func spikes_play():
	spikesPlay.play()
	
func blades_play():
	bladesPlay.play()
	
		
