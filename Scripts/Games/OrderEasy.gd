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

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("set_timer")
	emit_signal("update_title", "Order it")
	emit_signal("update_difficulty", "Easy")
	emit_signal("update_level", "1")
	emit_signal("set_visible_word", "Ave")
	emit_signal("uptate_imagen_game", "Ave")
	instance = pantallaVictoria.instantiate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func victory():
	instance.position = Vector2(1000,0)
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50

func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")


func _on_button_pressed():
	ButtonClick.button_click()
	$AudioStreamPlayer2D.play()
	victory()
