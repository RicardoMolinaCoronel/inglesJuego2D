extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var path = "user://puntajesPuzzle.dat"
	#if FileAccess.file_exists(path):
		#if DirAccess.remove_absolute(path) == OK:
			#print("Archivo existente borrado.")
		#else:
			#print("Error al intentar borrar el archivo.")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_texture_button_2_pressed():
	get_tree().quit()


func _on_texture_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")



func _on_texture_button_3_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/Global/PantallaPuntajes.tscn")
