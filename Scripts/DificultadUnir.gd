extends Node2D

#Signals
signal update_title(new_title)
signal update_difficulty(new_difficulty)
signal update_level(new_level)
signal set_not_visible_image()

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("update_title", "Match it Game")
	emit_signal("update_difficulty", "Easy")
	emit_signal("update_level", "1")
	emit_signal("set_not_visible_image")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")


func _on_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/SeleccionUnir.tscn")
