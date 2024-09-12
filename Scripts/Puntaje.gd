extends Node2D
var score = 0
var bonus = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Puntaje2.text = "+"+str(Score.fastBonus)
	$Puntaje3.text = "+"+str(Score.perfectBonus)
	updateScore()
	score = 0
	
	pass

func updateScore():
	bonus+=Score.fastBonus+Score.perfectBonus
	await get_tree().create_timer(1).timeout
	var tempScore = score
	while(score<(tempScore+Score.newScore+bonus)):
		await get_tree().create_timer(0.001).timeout
		score+=10
	Score.OrderItScore += score
	Score.PlayerScore+=score

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _process(delta):
	$Puntaje.text = str(score)

func _on_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")

