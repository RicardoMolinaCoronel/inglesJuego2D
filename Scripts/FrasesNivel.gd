extends Control


const STYLE_WORDS = "res://styles/FrasesNivelStyleButton.tres"
const SCRIPTS_PATH = "res://Escenas/Games/FrasesNivelComponents"
const url_fondo = "res://Sprites/global/Tabla.png"
#Signals
signal update_title(new_title)
signal update_difficulty(new_difficulty)
signal update_level(new_level)
signal set_visible_sentence(new_sentence)
signal uptate_imagen_game(new_image)
signal set_timer()

@onready var d_hbox = $Box_inside_game/DisordenateHBoxContainer
@onready var o_hbox = $Box_inside_game/OrdenateHBoxContainer

var start_texture_rect: TextureRect = null
var cadenas = ["He is", "playing", "football"]
var cadenasOrdenadas = ["He is", "playing", "football"]
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("update_title", "Puzzle")
	emit_signal("update_difficulty", "Easy")
	emit_signal("update_level", "1")
	emit_signal("set_visible_sentence", "El esta jugando futbol")
	emit_signal("uptate_imagen_game", "puzzle/futbol")
	emit_signal("set_timer")
	cargar_etiquetas_con_fondo(cadenas)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func cargar_etiquetas_con_fondo(cadenas: Array):
	cadenas.shuffle()
	var x=0
	for cadena in cadenas:
		#var containerCadena = TextureRect.new()
		#containerCadena.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		#containerCadena.custom_minimum_size = Vector2(225,100)
		#containerCadena.texture = load(url_fondo)
		#containerCadena.axis_stretch_horizontal =NinePatchRect.AXIS_STRETCH_MODE_STRETCH
		#containerCadena.axis_stretch_vertical =NinePatchRect.AXIS_STRETCH_MODE_STRETCH
		#containerCadena.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		#containerCadena.size_flags_horizontal = Control.SIZE_SHRINK_CENTER 
		#containerCadena.clip_contents = false
		var posicionCadena = cadenasOrdenadas.find(cadena)
		
		var button = Button.new()
		button.text = cadena	
		var estilo = preload(STYLE_WORDS)
		var tema = set_style(estilo)
		button.theme = tema		
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		button.name = "t_"+str(posicionCadena)
		var buttonScript = load(SCRIPTS_PATH+"/botonTextura.gd")
		button.set_script(buttonScript)
	# Ajustar las propiedades de anchor para centrar el botón
		#button.set_anchors_and_offsets_preset(Control.PRESET_CENTER, Control.PRESET_MODE_KEEP_SIZE)
		d_hbox.add_child(button)
		var ordenadaCadena = TextureRect.new()
		ordenadaCadena.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		ordenadaCadena.custom_minimum_size = Vector2(225,100)
		ordenadaCadena.name = "t_"+str(x)
		var textureScript = load(SCRIPTS_PATH+"/TextureRect.gd")
		ordenadaCadena.set_script(textureScript)
		#var panelOrdenada = Panel.new()
		#panelOrdenada.mouse_filter =Control.MOUSE_FILTER_IGNORE
		#panelOrdenada.show_behind_parent = true
		#ordenadaCadena.add_child(panelOrdenada)
		ordenadaCadena.texture = load(url_fondo)
		
		o_hbox.add_child(ordenadaCadena)
		x+=1

func set_style(estilo):
	var tema = Theme.new()
	tema.set_stylebox('normal', "Button", estilo.get_stylebox("normal", "Button"))
	#tema.set_stylebox('hover', "Button",  estilo.get_stylebox("hover", "Button"))
	#tema.set_stylebox('pressed', "Button",  estilo.get_stylebox("pressed", "Button"))
	#tema.set_stylebox('focus', "Button",  estilo.get_stylebox("focus", "Button"))
	tema.set_font("font", "Button", estilo.get_font("font", "Button"))
	tema.set_font_size("font_size", "Button", estilo.get_font_size("font_size", "Button"))
	tema.set_color("font_color", "Button", estilo.get_color("font_color", "Button"))
	tema.set_color("font_focus_color", "Button", estilo.get_color("font_focus_color", "Button"))
	#tema.set_color("font_hover_color", "Button", estilo.get_color("font_hover_color", "Button"))
	#tema.set_color("font_hover_pressed_color", "Button", estilo.get_color("font_hover_pressed_color", "Button"))
	#tema.set_color("font_outline_color", "Button", estilo.get_color("font_outline_color", "Button"))
	tema.set_color("font_pressed_color", "Button", estilo.get_color("font_pressed_color", "Button"))
	return tema

func _on_btn_go_back_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")
