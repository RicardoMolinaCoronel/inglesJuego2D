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
var instance
var palabra ="bird"
var instantiated = false
var gano = false
var palabrasEsp = ["El esta jugando futbol", "Le gusta jugar futbol"]
var cadenas = [["He is", "playing", "football"], ["He likes", "to play", "football"]]
var cadenasOrdenadas = [["He is", "playing", "football"], ["He likes", "to play", "football"]]
var indiceCadena = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var random_index = randi() % cadenas.size()
	indiceCadena = random_index
	emit_signal("set_timer")
	emit_signal("update_title", "Puzzle")
	emit_signal("update_difficulty", "Easy")
	emit_signal("update_level", "1")
	emit_signal("uptate_imagen_game", "puzzle/futbol1")
	emit_signal("set_visible_sentence", palabrasEsp[random_index])
	update_boxes(random_index)
	instance = pantallaVictoria.instantiate()
	instantiated = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(instantiated):
		if ($Cadenas/Pieza0.correct and $Cadenas/Pieza1.correct and
		  $Cadenas/Pieza2.correct and !gano):
			gano = true
			victory()
	pass

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
		
	
func victory():
	instance.position = Vector2(1000,0)
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
	

func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")


