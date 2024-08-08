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



# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("set_timer")
	emit_signal("update_scene", "menu_juegos")
	emit_signal("update_title", title)
	emit_signal("update_difficulty", difficulty)
	emit_signal("update_level", str(level))
	emit_signal("set_not_visible_image")
	var complete_path = PATH_IMAGES + 'level' + str(level) + '/' + difficulty
	var nombres_imagenes = obtener_nombres_imagenes(complete_path)
	cargar_imagenes_en_vbox(complete_path, nombres_imagenes)
	cargar_etiquetas_con_fondo(nombres_imagenes)
	
	clear_lines()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if drawing:
			end_line(event)
		else:
			start_line(event)


func start_line(event):
	var clicked_texture_rect = get_texture_rect_at(event.position)
	if clicked_texture_rect:
		if not active_lines_from_image.has(clicked_texture_rect):
			drawing = true
			start_position = clicked_texture_rect.get_global_position() + (clicked_texture_rect.get_size() / 2)  # Center of the texture
			temp_line = Line2D.new()
			temp_line.width = line_width
			temp_line.default_color = line_color
			temp_line.add_point(start_position)
			temp_line.add_point(start_position)  # Start with the same point
			line_container.add_child(temp_line)
			start_texture_rect = clicked_texture_rect
		else:
			# Allow modifying the existing line by removing it
			var existing_line = active_lines_from_image[clicked_texture_rect]
			if existing_line and is_instance_valid(existing_line):
				existing_line.queue_free()
			active_lines_from_image.erase(clicked_texture_rect)
			drawing = true
			start_position = clicked_texture_rect.get_global_position() + (clicked_texture_rect.get_size() / 2)
			temp_line = Line2D.new()
			temp_line.width = line_width
			temp_line.default_color = line_color
			temp_line.add_point(start_position)
			temp_line.add_point(start_position)
			line_container.add_child(temp_line)
			start_texture_rect = clicked_texture_rect

func end_line(event):
	var clicked_button = get_button_at(event.position) 
	if clicked_button:
		end_position = clicked_button.get_global_position()  + (clicked_button.get_size() / 2)
		
		if active_line_to_button.has(clicked_button):
			var existing_line = active_line_to_button[clicked_button]
			if existing_line and is_instance_valid(existing_line):
				existing_line.queue_free()
			active_line_to_button.erase(clicked_button)
		
		var new_line = Line2D.new()
		new_line.width = line_width
		new_line.default_color = line_color
		new_line.add_point(start_position)
		new_line.add_point(end_position)
		line_container.add_child(new_line)
		
		active_line_to_button[clicked_button] = new_line
		active_lines_from_image[start_texture_rect] = new_line
		
		if temp_line:
			temp_line.queue_free()
			temp_line = null
		drawing = false
		
func get_texture_rect_at(position) -> TextureRect:
	for texture_rect in v_box_images.get_children():
		if texture_rect.get_global_rect().has_point(position):
			return texture_rect
	return null

func get_button_at(position) -> Button:
	for button in v_box_words.get_children():
		if button.get_global_rect().has_point(position):
			return button
	return null

func _process(delta):
	if drawing and temp_line:
		temp_line.set_point_position(1, get_global_mouse_position())

func clear_lines():
	for child in line_container.get_children():
		if child:
			child.queue_free()
	active_lines_from_image.clear()
	active_line_to_button.clear()

func obtener_nombres_imagenes(ruta: String) -> Array:
	var dir = DirAccess.open(ruta)
	var nombres_imagenes = []

	if dir:
		dir.list_dir_begin()
		var archivo = dir.get_next()

		while archivo != "":
			if not dir.current_is_dir() and archivo.ends_with(".png"):
				nombres_imagenes.append(archivo)
			archivo = dir.get_next()

		dir.list_dir_end()
	else:
		print("No se pudo abrir la carpeta")

	return nombres_imagenes

func cargar_imagenes_en_vbox(path, nombres_imagenes):
	for nombre in nombres_imagenes:
		var texture = load(path + '/' + nombre)
		var texture_rect = TextureRect.new()
		texture_rect.texture = texture
		
		# Configurar modo de estiramiento
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
		texture_rect.expand_mode = TextureRect.EXPAND_FIT_HEIGHT
		
		texture_rect.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND

		v_box_images.add_child(texture_rect)

func cargar_etiquetas_con_fondo(nombres_imagenes: Array):
	nombres_imagenes.shuffle()
	
	for nombre in nombres_imagenes:
		var button = Button.new()
		button.text = nombre.replace(".png", "").capitalize()
		
		
		var estilo = preload(STYLE_WORDS)
		var tema = set_style(estilo)
		button.theme = tema
		
		button.size_flags_horizontal = Control.SIZE_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
		 
		v_box_words.add_child(button)

func set_style(estilo):
	var tema = Theme.new()
	tema.set_stylebox('normal', "Button", estilo.get_stylebox("normal", "Button"))
	tema.set_stylebox('hover', "Button",  estilo.get_stylebox("hover", "Button"))
	tema.set_stylebox('pressed', "Button",  estilo.get_stylebox("pressed", "Button"))
	tema.set_stylebox('focus', "Button",  estilo.get_stylebox("focus", "Button"))
	tema.set_font("font", "Button", estilo.get_font("font", "Button"))
	tema.set_font_size("font_size", "Button", estilo.get_font_size("font_size", "Button"))
	tema.set_color("font_color", "Button", estilo.get_color("font_color", "Button"))
	tema.set_color("font_focus_color", "Button", estilo.get_color("font_focus_color", "Button"))
	tema.set_color("font_hover_color", "Button", estilo.get_color("font_hover_color", "Button"))
	tema.set_color("font_hover_pressed_color", "Button", estilo.get_color("font_hover_pressed_color", "Button"))
	tema.set_color("font_outline_color", "Button", estilo.get_color("font_outline_color", "Button"))
	tema.set_color("font_pressed_color", "Button", estilo.get_color("font_pressed_color", "Button"))
	
	return tema
