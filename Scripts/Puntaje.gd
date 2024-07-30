extends Node2D
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	updateScore()
	pass

func updateScore():
	await get_tree().create_timer(1).timeout
	while(score<1000):
		await get_tree().create_timer(0.001).timeout
		score+=10

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout


func _process(delta):
	$Puntaje.text = str(score)
	


func _on_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")

