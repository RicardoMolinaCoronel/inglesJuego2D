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

var active_line: Dictionary = {}
var active_lines_from_image: Dictionary = {}
var active_line_to_button: Dictionary = {}
var drawing : bool = false
var start_position : Vector2
var temp_line: Line2D = null
var start_texture_rect: TextureRect = null

var line_width : float = 8.0
var line_color : Color = Color(1, 0, 0)

var end_position : Vector2
var clear_delay: float = 0.2
var last_clear_time: float = 0.0

var selected_image: Node2D = null
var image1 = "res://Sprites/images_games/match/level1/easy/Iguana.png"
var image2 = "res://Sprites/images_games/match/level1/easy/Squirrel.png"
var image3 = "res://Sprites/images_games/match/level1/easy/Woodpecker.png"

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


func handle_value_selected(node):
	if(selected_image and not node == selected_image):
		selected_image.fondo_clic.visible = false
	selected_image = node
	
func handle_value_match(target_node):
	if !selected_image:
		target_node.fondo_clic.visible = false
		return
	if selected_image.value == target_node.target:
		print("¡Es un match!")
		selected_image.blocked = true
		target_node.blocked = true
		selected_image.animation_match()
		target_node.animation_match()
	else:
		print("No es un match")
		selected_image.animation_no_match()
		target_node.animation_no_match()
		selected_image.fondo_clic.visible = false
	selected_image = null
