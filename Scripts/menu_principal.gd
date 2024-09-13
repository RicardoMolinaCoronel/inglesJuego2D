extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	create_scores_directory()
	'''
	var path = "user://puntajesPuzzle.dat"
	var path1 = "user://puntajesMatch.dat"
	var path2 = "user://puntajesOrder.dat"
	if FileAccess.file_exists(path):
		if DirAccess.remove_absolute(path) == OK:
			print("Archivo existente borrado.")
		else:
			print("Error al intentar borrar el archivo.")
	if FileAccess.file_exists(path1):
		if DirAccess.remove_absolute(path1) == OK:
			print("Archivo existente borrado.")
		else:
			print("Error al intentar borrar el archivo.")
	if FileAccess.file_exists(path2):
		if DirAccess.remove_absolute(path2) == OK:
			print("Archivo existente borrado.")
		else:
			print("Error al intentar borrar el archivo.")				
	'''
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_texture_button_2_pressed():
	get_tree().quit()


func _on_texture_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")

func create_scores_directory():
	var path = OS.get_executable_path().get_base_dir()+"/Scores/"
	
	# Verifica si el directorio ya existe
	if DirAccess.dir_exists_absolute(path) == false:
		var err = DirAccess.make_dir_absolute(path)  # Crea el directorio
		if err != OK:
			print("Error al crear el directorio Scores:", err)
		else:
			print("Directorio Scores ya existe")

	return path



func _on_texture_button_3_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/Global/PantallaPuntajes.tscn")
