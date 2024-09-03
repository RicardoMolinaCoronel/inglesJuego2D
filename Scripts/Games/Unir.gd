extends Node2D

#Constants
const PATH_IMAGES = "res://Sprites/images_games/match/"
const ASSET_TABLA = "res://Sprites/global/Tabla.png"
const STYLE_WORDS = "res://styles/UnirFacil1_Style_Words.tres"

#Signals
signal update_scene(path)
signal update_title(new_title)
signal set_timer()
signal update_difficulty(new_difficulty)
signal update_level(new_level)
signal set_not_visible_image()

@onready var v_box_images = $VBoxImages
@onready var v_box_words = $VBoxWords
@onready var line_container = $line_container

#variables
var level = 1
var difficulty = 'easy'
var title = "match it"

var selected_image: Node2D = null
var image1 = "res://Sprites/images_games/match/level1/easy/Iguana.png"
var image2 = "res://Sprites/images_games/match/level1/easy/Squirrel.png"
var image3 = "res://Sprites/images_games/match/level1/easy/Woodpecker.png"

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

	$Box_imagen_match.put_image(image1, "iguana")
	$Box_imagen_match2.put_image(image2, "squirrel")
	$Box_imagen_match3.put_image(image3, "woodpecker")
	instance = pantallaVictoria.instantiate()
	instantiated = true

func _process(_delta):
	if(instantiated):
		if($Box_texto_match.is_matched() and $Box_texto_match2.is_matched() and $Box_texto_match3.is_matched() and !gano):
			gano = true
			victory()

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

func victory():
	instance.position = Vector2(1000,0)
	$AudioStreamPlayer2D.play()
	$AnimationPlayer.play("Win")
	await $AnimationPlayer.animation_finished
	add_child(instance)
	while(instance.position.x > 0):
		await get_tree().create_timer(0.000000001).timeout
		instance.position.x-=50
