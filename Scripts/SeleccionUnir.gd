extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/DificultadUnir.tscn")


func _on_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/SeleccionUnir.tscn")


func _on_button_level1_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/UnirFacil1.tscn")
