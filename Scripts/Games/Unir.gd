extends Node2D

#Signals
signal update_scene(path)
signal update_title(new_title)
signal set_timer()
signal update_difficulty(new_difficulty)
signal update_level(new_level)
signal set_not_visible_image()

#variables
var level = 1
var difficulty = 'easy'
var title = "match it"
var rondas = 4
var numeroRondas = 1
var ganoRonda = false

var selected_image: Node2D = null
var image1 = "res://Sprites/images_games/match/easy/Iguana.png"
var image2 = "res://Sprites/images_games/match/easy/Squirrel.png"
var image3 = "res://Sprites/images_games/match/easy/Woodpecker.png"
var image4 = "res://Sprites/images_games/match/easy/Ant-eater.png"
var image5 = "res://Sprites/images_games/match/easy/Baltimore oriole.png"
var image6 = "res://Sprites/images_games/match/easy/Cricket.png"
var image7 = "res://Sprites/images_games/match/easy/Gray-backed Hawk.png"
var image8 = "res://Sprites/images_games/match/easy/Great white heron.png"
var image9 = "res://Sprites/images_games/match/easy/Howler monkey.png"
var image10 = "res://Sprites/images_games/match/easy/Red-crowned parrot.png"
var image11 = "res://Sprites/images_games/match/easy/Sloth.png"
var image12 = "res://Sprites/images_games/match/easy/Turquoise Butterfly.png"

@onready var box_imagen_match = $Box_imagen_match
@onready var box_imagen_match_2 = $Box_imagen_match2
@onready var box_imagen_match_3 = $Box_imagen_match3
@onready var box_texto_match = $Box_texto_match
@onready var box_texto_match_2 = $Box_texto_match2
@onready var box_texto_match_3 = $Box_texto_match3


var instantiated: bool = false
var gano: bool = false
var pantallaVictoria = preload("res://Escenas/PantallaVictoria.tscn")
var instance

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("set_timer")
	emit_signal("update_scene", "menu_juegos")
	emit_signal("update_title", title)
	emit_signal("update_difficulty", difficulty)
	emit_signal("update_level", str(level))
	emit_signal("set_not_visible_image")
	instance = pantallaVictoria.instantiate()
	instantiated = true
	iniciar_juego()

func _process(_delta):
	if(instantiated):
		
		if(box_texto_match.is_matched() and box_texto_match_2.is_matched() and
		box_texto_match_3.is_matched() and numeroRondas == rondas and !gano):
			gano = true
			victory()
		elif (box_texto_match.is_matched() and box_texto_match_2.is_matched() and
		 box_texto_match_3.is_matched() and numeroRondas < rondas and !ganoRonda and !gano):
			ganoRonda = true
			numeroRondas+=1
			if(numeroRondas <= rondas):
				ronda_win()

func handle_value_selected(node):
	if(selected_image and not node == selected_image):
		selected_image.fondo_clic.visible = false
	selected_image = node
	
func handle_value_match(target_node):
	if !selected_image:
		target_node.fondo_clic.visible = false
		return
	if selected_image.value == target_node.target:
		selected_image.blocked = true
		target_node.blocked = true
		selected_image.animation_match()
		target_node.animation_match()
		target_node.mark_to_match()
		$AnimationPlayer.play("correct")
	else:
		selected_image.animation_no_match()
		target_node.animation_no_match()
		selected_image.fondo_clic.visible = false
		$AnimationPlayer.play("incorrect")
	selected_image = null
	
	
func iniciar_juego():
	emit_signal("update_level", str(numeroRondas)+"/4")
	box_imagen_match.put_image(image1, "iguana")
	box_imagen_match_2.put_image(image2, "squirrel")
	box_imagen_match_3.put_image(image3, "woodpecker")
	box_texto_match.put_text("squirrel")
	box_texto_match_2.put_text("woodpecker")
	box_texto_match_3.put_text("iguana")
	ganoRonda=false
	
func cargar_ronda():
	reset_compoments()
	if numeroRondas == 2:
		emit_signal("update_level", str(numeroRondas)+"/4")
		box_imagen_match.put_image(image4, "ant eater")
		box_imagen_match_2.put_image(image5, "baltimore oriole")
		box_imagen_match_3.put_image(image6, "cricket")
		box_texto_match.put_text("baltimore oriole")
		box_texto_match_2.put_text("ant eater")
		box_texto_match_3.put_text("cricket")
	elif numeroRondas == 3:
		emit_signal("update_level", str(numeroRondas)+"/4")
		box_imagen_match.put_image(image7, "gray-backed Hawk")
		box_imagen_match_2.put_image(image8, "great white heron")
		box_imagen_match_3.put_image(image9, "howler monkey")
		box_texto_match.put_text("howler monkey")
		box_texto_match_2.put_text("great white heron")
		box_texto_match_3.put_text("gray-backed Hawk")
	elif numeroRondas == 4:
		emit_signal("update_level", str(numeroRondas)+"/4")
		box_imagen_match.put_image(image10, "red-crowned parrot")
		box_imagen_match_2.put_image(image11, "sloth")
		box_imagen_match_3.put_image(image12, "turquoise Butterfly")
		box_texto_match.put_text("red-crowned parrot")
		box_texto_match_2.put_text("turquoise Butterfly")
		box_texto_match_3.put_text("sloth")
	ganoRonda=false
	
func reset_compoments():
	box_imagen_match.animation_reset()
	box_imagen_match_2.animation_reset()
	box_imagen_match_3.animation_reset()
	box_texto_match.animation_reset()
	box_texto_match_2.animation_reset()
	box_texto_match_3.animation_reset()

func ronda_win():
	animation_win()
	cargar_ronda()
	
func _dar_pista():
	var images = [box_imagen_match, box_imagen_match_2, box_imagen_match_3]
	var words = [box_texto_match, box_texto_match_2, box_texto_match_3]
	var indices_a_eliminar = []
	for i in range(images.size()):
		if(images[i].blocked):
			indices_a_eliminar.append(i)
			
	indices_a_eliminar.reverse()
	for i in indices_a_eliminar:
		images.pop_at(i)
	
	images.shuffle()
	var image_pista = images.pop_front()
	
	for word in words:
		if image_pista.value == word.target:
			image_pista.animation_pista()
			word.animation_pista()

func victory():
	$AudioStreamPlayer2D.play()
	instance.position = Vector2(1000,0)
	animation_win()
	await $AnimationPlayer.animation_finished
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50
		
func animation_win():
	$AnimationPlayer.play("Win")
	await $AnimationPlayer.animation_finished
	
