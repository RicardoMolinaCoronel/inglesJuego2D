extends Node2D

#Signals
signal set_timer()
signal update_title(new_title)
signal update_difficulty(new_difficulty)
signal update_level(new_level)
signal uptate_imagen_game(new_image)
signal set_visible_word(new_word)
var pantallaVictoria = preload("res://Escenas/PantallaVictoria.tscn")
var instance
@export var palabra ="bird"
@export var palabraES = "Ave"
var instantiated = false
var gano = false
var Letters = palabra.split()




func _ready():
	emit_signal("set_timer")
	emit_signal("update_title", "Order it")
	emit_signal("update_difficulty", "Easy")
	emit_signal("update_level", "1")
	emit_signal("set_visible_word", "Ave")
	emit_signal("uptate_imagen_game", "Ave")
	instance = pantallaVictoria.instantiate()
	instantiated = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(instantiated):
		if ($Letras/Letter.correct and $Letras/Letter2.correct and
		 $Letras/Letter3.correct and $Letras/Letter4.correct and !gano):
			gano = true
			victory()
	pass


func victory():
	Score.newScore=1000
	Score.LatestGame = Score.Games.OrderIt
	instance.position = Vector2(1000,0)
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Gana")
	await $AnimationPlayer.animation_finished
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50
	

func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")


