extends Control


# Called when the node enters the scene tree for the first time.
func _ready():

	'''
	#Ruta donde se encuentra el ejecutable
	var ejecutablePath = Global.rutaArchivos
	var path = ejecutablePath+"/Scores/puntajesPuzzle.dat"
	var path1 = ejecutablePath+"/Scores/puntajesMatch.dat"
	var path2 = ejecutablePath+"/Scores/puntajesOrder.dat"
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
	var pathPr = Global.rutaArchivos+"/Progress/progressMinigames.dat"
	if FileAccess.file_exists(pathPr):
		if DirAccess.remove_absolute(pathPr) == OK:
			print("Archivo existente borrado.")
		else:
			print("Error al intentar borrar el archivo.")				
	pass
	initialize_directories()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_texture_button_2_pressed():
	get_tree().quit()


func _on_texture_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")

func create_progress_file(path):
	if !FileAccess.file_exists(path):  # Verifica si el archivo existe
		var content = {
			"puzzle":{
				"easy":true,
				"medium":false,
				"hard":false,
				"firstMedium":false,
				"firstHard":false,				
			},
			"match":{
				"easy":true,
				"medium":false,
				"hard":false,
				"firstMedium":false,
				"firstHard":false,
			},
			"order":{
				"easy":true,
				"medium":false,
				"hard":false,
				"firstMedium":false,
				"firstHard":false,				
			},
		}
		var file = FileAccess.open(path ,FileAccess.WRITE)
		file.store_var(content)
		file = null
		

func initialize_directories():
	var path = Global.rutaArchivos+"/Scores/"
	var path1 = Global.rutaArchivos+"/Progress/"
	# Verifica si el directorio ya existe
	if DirAccess.dir_exists_absolute(path) == false:
		var err = DirAccess.make_dir_absolute(path)  # Crea el directorio
		if err != OK:
			print("Error al crear el directorio Scores:", err)
		else:
			print("Directorio Scores ya existe")
	if DirAccess.dir_exists_absolute(path1) == false:
		var err1 = DirAccess.make_dir_absolute(path1)  # Crea el directorio
		if err1 != OK:
			print("Error al crear el directorio Progress:", err1)
		else:
			create_progress_file(path1+"progressMinigames.dat")
			print("Directorio Scores ya existe")
	pass



func _on_texture_button_3_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/Global/PantallaPuntajes.tscn")
