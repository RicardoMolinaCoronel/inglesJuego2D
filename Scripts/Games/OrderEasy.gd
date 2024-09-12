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
var palabras = {"Ave": "BIRD", "Pelota": "BALL", "Gavilán": "HAWK", "Pozo": "WELL"}
@export var palabra ="BIRD"
@export var palabraES = "Ave"
var instantiated = false
var gano = false
var letters
var rondas = 4
var rondaActual = 1
var tiempoCronometro
var velocidad = 20
var perfect = false

func _ready():
	Score.perfectBonus = true
	emit_signal("set_timer")
	emit_signal("update_title", "Order it")
	emit_signal("update_difficulty", "Easy")
	emit_signal("update_level", "1/4")
	emit_signal("uptate_imagen_game", "Ave")
	instance = pantallaVictoria.instantiate()
	instantiated = true
	setLetters()
	tiempoCronometro = $Box_inside_game.time_seconds
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(instantiated):
		if ($Letras/Letter.correct and $Letras/Letter2.correct and
		 $Letras/Letter3.correct and $Letras/Letter4.correct and
		 rondaActual==rondas and !gano):
			gano = true
			victory()
		if ($Letras/Letter.correct and $Letras/Letter2.correct and
		 $Letras/Letter3.correct and $Letras/Letter4.correct):
			if(rondaActual<rondas):
				await nuevaRonda()
			else: gano=true
	pass

func setLetters():
	palabraES = palabras.keys().pick_random()
	emit_signal("set_visible_word", palabraES)
	palabra = palabras[palabraES]
	letters = palabra.split()
	var tempLetters: Array[String]= []
	while(true):
		tempLetters= []
		for i in letters.size():
			tempLetters.append(letters[i])
		tempLetters.shuffle()
		if (tempLetters[0]!=letters[0]):
			break
	$Letras/Letter.setLetter(tempLetters[0])
	$Letras/Letter2.setLetter(tempLetters[1])
	$Letras/Letter3.setLetter(tempLetters[2])
	$Letras/Letter4.setLetter(tempLetters[3])
	$Ordenada/Letterbox5.setLetter(letters[0])
	$Ordenada/Letterbox6.setLetter(letters[1])
	$Ordenada/Letterbox7.setLetter(letters[2])
	$Ordenada/Letterbox8.setLetter(letters[3])

func victory():
	actualizar_velocidad()
	Score.newScore=300
	Score.fastBonus=velocidad
	Score.LatestGame = Score.Games.OrderIt
	instance.position = Vector2(1000,0)
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Gana")
	await $AnimationPlayer.animation_finished
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50

func _dar_pista():
	for i in $Letras.get_children():
		if(!i.correct):
			for j in $Ordenada.get_children():
				if(j.letter == i.letter and !j.occupied):
					i.hint()
					j.hint()
					return
					
func nuevaRonda():
	rondaActual+=1
	emit_signal("update_level", str(rondaActual)+"/4")
	palabras.erase(palabraES)
	$Letras/Letter.resetVars()
	$Letras/Letter2.resetVars()
	$Letras/Letter3.resetVars()
	$Letras/Letter4.resetVars()
	await $Letras/Letter.animacionFinalizado()
	await $Letras/Letter2.animacionFinalizado()
	await $Letras/Letter3.animacionFinalizado()
	await $Letras/Letter4.animacionFinalizado()
	$Letras/Letter.resetPos()
	$Letras/Letter2.resetPos()
	$Letras/Letter3.resetPos()
	$Letras/Letter4.resetPos()
	setLetters()

func actualizar_velocidad():
	var tiempoFinal = $Box_inside_game.time_seconds
	if (tiempoFinal >  tiempoCronometro/1.8):
		velocidad+=80
	elif (tiempoFinal >  tiempoCronometro/2):
		velocidad+=60
	elif (tiempoFinal >  tiempoCronometro/4):
		velocidad+=40
	else:
		velocidad+=0

