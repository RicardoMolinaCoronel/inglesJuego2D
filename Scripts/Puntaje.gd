extends Node2D
var pantallaVictoria = preload("res://Escenas/PantallaVictoria.tscn")
var instance
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	instance = pantallaVictoria.instantiate()
	
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
	$Label.text = str(score)
	

func victory():
	instance.position = Vector2(1000,0)
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50
	

func _on_button_pressed():
	ButtonClick.button_click()
	victory()
