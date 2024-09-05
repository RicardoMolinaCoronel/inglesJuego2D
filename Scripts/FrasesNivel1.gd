extends Node2D

#Signals
signal set_timer()
signal update_title(new_title)
signal update_difficulty(new_difficulty)
signal update_level(new_level)
signal uptate_imagen_game(new_image)
#signal set_visible_word(new_word)
signal set_visible_sentence(new_sentence)
signal update_phrase()
var pantallaVictoria = preload("res://Escenas/PantallaVictoria.tscn")
var pantallaAcaboTiempo = preload("res://Escenas/NivelFinalizado.tscn")
var difuminado = preload("res://Piezas/ColorRectDifuminado.tscn")
var instance
#var palabra ="bird"
var instantiated = false
var instanceAcaboTiempo
var instantiatedAcaboTiempo = false
var instanceDifuminado
var instantiatedDifuminado = false
var gano = false
var ganoRonda = false
var palabrasEsp = ["El está jugando futbol", "A el le gusta jugar futbol", "El juega fútbol todos los días" , "El patea muy fuerte"]
var cadenas = [["He is", "playing", "football"], ["He likes", "to play", "football"], ["He plays", "football", "everyday"], ["He hits", "the ball", "very hard"]]
var cadenasOrdenadas = [["He is", "playing", "football"], ["He likes", "to play", "football"], ["He plays", "football", "everyday"], ["He hits", "the ball", "very hard"]]
var indiceCadena = -1
var estadoInicialPiezas = []
var rondas = 4
var numeroRondas = 0
var precisionMinima = 20
var precisionActual = 100
var velocidad = 20
var valorNivel = 100
var tiempoCronometro = 120
# Called when the node enters the scene tree for the first time.
func _ready():
	instance = pantallaVictoria.instantiate()
	instantiated = true
	instanceAcaboTiempo = pantallaAcaboTiempo.instantiate()
	instantiatedAcaboTiempo = true
	instanceDifuminado = difuminado.instantiate()
	instantiatedDifuminado = true
	emit_signal("set_timer")
	emit_signal("update_title", "Puzzle")
	emit_signal("update_difficulty", "Easy")
	emit_signal("uptate_imagen_game", "puzzle/futbol1")
	for i in range(3):
		var pieza = $Cadenas.get_node("Pieza"+str(i))
		estadoInicialPiezas.append({"position": pieza.position})
	tiempoCronometro = $Box_inside_game.time_seconds
	_empezar_ronda()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(instantiated):
		if ($Cadenas/Pieza0.correct and $Cadenas/Pieza1.correct and
		  $Cadenas/Pieza2.correct and numeroRondas == rondas and !gano):
			gano = true
			victory()
		elif ($Cadenas/Pieza0.correct and $Cadenas/Pieza1.correct and
		  $Cadenas/Pieza2.correct and numeroRondas < rondas and !ganoRonda and !gano):
			ganoRonda = true
			numeroRondas+=1
			if(numeroRondas < rondas):		
				rondaWin()
			
	pass

func _empezar_ronda():		
	indiceCadena += 1	
	emit_signal("set_visible_sentence", palabrasEsp[indiceCadena])
	emit_signal("update_level", str(indiceCadena+1)+"/4")
	update_boxes(indiceCadena)
	ganoRonda=false
	

func _reiniciar_componentes():
	var x=0
	for dicc in estadoInicialPiezas:
		var pieza = $Cadenas.get_node("Pieza"+str(x))
		var piezaBox = $Ordenada.get_node("piezaBox"+str(x))
		pieza.position = dicc["position"]
		pieza._reiniciar_variables()
		piezaBox._reiniciar_variables()
		x+=1
	_animacion_retorno()
	_empezar_ronda()

func _animacion_retorno():
	for i in range(3):
		var pieza = $Cadenas.get_node("Pieza"+str(i))
		pieza._animacion_retorno()
	
	
func _dar_pista():
	var numeros = [0, 1, 2] 
	while numeros.size() > 0:
		# Selecciona un índice aleatorio dentro del rango de la lista
		var indice_aleatorio = randi() % numeros.size()     
		# Obtiene el número en el índice aleatorio
		var numero_seleccionado = numeros[indice_aleatorio]        
		var pieza = "Pieza"+str(numero_seleccionado)
		var nodePieza = $Cadenas.get_node(pieza)
		if(!nodePieza.correct):
			var posicionCadena = cadenasOrdenadas[indiceCadena].find(nodePieza.letter)
			var piezaBox = "piezaBox"+str(posicionCadena)
			var nodePiezaBox = $Ordenada.get_node(piezaBox)
			nodePieza._animacion_pista()
			nodePiezaBox._animacion_pista()	
			return	 	
		numeros.remove_at(indice_aleatorio) 
	

func update_boxes(index: int):
	cadenas[index].shuffle()
	var x=0	
	for cadena in cadenas[index]:
		var nombrePieza = "Pieza"+str(x)
		var nombrePiezaBox = "piezaBox"+str(x)
		var pieza_objetivo = get_node("Cadenas/"+nombrePieza)
		pieza_objetivo.letter = cadena
		var pieza_box_objetivo = get_node("Ordenada/"+nombrePiezaBox)
		pieza_box_objetivo.letter = cadenasOrdenadas[index][x]
		x+=1
		var posicion = cadenasOrdenadas[index].find(cadena)
		var sprite_pz_objetivo = get_node("Cadenas/"+nombrePieza+"/InteractivoLetra(vacio)")
		cargar_nueva_textura(sprite_pz_objetivo, posicion)
		
		
	emit_signal("update_phrase")
		
		
func cargar_nueva_textura(sprite, index):
	var nueva_textura
	if index==0:
		nueva_textura = load("res://Sprites/mini_games/pieza3.png")
	elif index==1:
		nueva_textura = load("res://Sprites/mini_games/pieza1.png")
	else:
		nueva_textura = load("res://Sprites/mini_games/pieza2.png")
	sprite.texture = nueva_textura
		
func _actualizar_velocidad():
	var tiempoFinal = $Box_inside_game.time_seconds
	if (tiempoFinal >  tiempoCronometro/1.8):
		velocidad+=80
	elif (tiempoFinal >  tiempoCronometro/2):
		velocidad+=60
	elif (tiempoFinal >  tiempoCronometro/4):
		velocidad+=40
	else:
		velocidad+=0
	var content = {"niveles": valorNivel, "velocidad": velocidad}

func _actualizar_puntajes(path):
	var content
	if FileAccess.file_exists(path):  # Verifica si el archivo existe  
		var file = FileAccess.open(path, FileAccess.READ)# Abre el archivo en modo lectura
		var puntajes = file.get_var()  # Lee el diccionario de puntajes almacenado
		file.close()  # Cierra el archivo después de leer
		print("Puntajes cargados: ", puntajes)
		var velocidadPasada = puntajes["easy"]["velocidad"]
		var precisionPasada = puntajes["easy"]["precision"]
		var nivelesPasado = puntajes["easy"]["niveles"]
		content = {
			"easy": {
				"velocidad":velocidadPasada,
				"precision":precisionPasada,
				"niveles":nivelesPasado	
			},"medium": {
				"velocidad":0,
				"precision":0,
				"niveles":0
			},"hard": {
				"velocidad":0,
				"precision":0,
				"niveles":0	
			}
		}
		if int(velocidadPasada) < velocidad:
			content["easy"]["velocidad"] = velocidad
		if int(precisionPasada) < precisionActual:
			content["easy"]["precision"] = precisionActual
		if int(nivelesPasado) < valorNivel:
			content["easy"]["niveles"] = valorNivel
		if int(velocidadPasada) < velocidad || int(precisionPasada) < precisionActual || int(nivelesPasado) < valorNivel:
			if DirAccess.remove_absolute(path) == OK:
	 
				print("Archivo existente borrado.")
				_guardar_puntajes(content, path)
			else:
				print("Error al intentar borrar el archivo.")
		
		
	else:
		content = {
			"easy": {
				"velocidad":velocidad,
				"precision":precisionActual,
				"niveles":valorNivel	
			},"medium": {
				"velocidad":0,
				"precision":0,
				"niveles":0
			},"hard": {
				"velocidad":0,
				"precision":0,
				"niveles":0	
			}
		}
		_guardar_puntajes(content, path)		
		
			 
	

func _guardar_puntajes(content, path):
	var file = FileAccess.open(path ,FileAccess.WRITE)
	file.store_var(content)
	file = null

func victory():
	var totalActual = velocidad+precisionActual+valorNivel

	Score.newScore = totalActual
	Score.LatestGame = Score.Games.Puzzle
	instance.position = Vector2(1000,0)
	$Box_inside_game.timer.stop()
	_actualizar_velocidad()
	print("Velocidad: "+str(velocidad)+", "+"Precision: "+str(precisionActual)+", "+"Niveles: "+str(valorNivel)+", Total: "+str(totalActual))
	_actualizar_puntajes("user://puntajesPuzzle.dat")
	$AnimationPlayer.play("Gana")
	var pieza0 = get_node("Cadenas/Pieza0")
	var pieza1 = get_node("Cadenas/Pieza1")
	var pieza2 = get_node("Cadenas/Pieza2")
	await pieza0._animacion_finalizado()
	await pieza1._animacion_finalizado()
	await pieza2._animacion_finalizado()
	await $AnimationPlayer.animation_finished
	$AudioStreamPlayer2D.play()
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50

func lose():
	$Box_inside_game.timer.stop()
	get_tree().paused = true
	instanceAcaboTiempo.nombreEscenaDificultad = "DificultadOracion1.tscn"
	instanceAcaboTiempo.position = Vector2(1000,0)
	var canvas_layer = CanvasLayer.new()
	canvas_layer.add_child(instanceDifuminado)
	var canvas_layer1 = CanvasLayer.new()
	canvas_layer1.add_child(instanceAcaboTiempo)
	add_child(canvas_layer)
	add_child(canvas_layer1)
	while(instanceAcaboTiempo.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instanceAcaboTiempo.position.x-=50

func rondaWin():
	$AnimationPlayer.play("Gana")
	var pieza0 = get_node("Cadenas/Pieza0")
	var pieza1 = get_node("Cadenas/Pieza1")
	var pieza2 = get_node("Cadenas/Pieza2")
	await pieza0._animacion_finalizado()
	await pieza1._animacion_finalizado()
	await pieza2._animacion_finalizado()
	await $AnimationPlayer.animation_finished
	_reiniciar_componentes()
	

func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")


