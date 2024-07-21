extends Node2D

const PATH_IMAGE_GAME = "res://Sprites/images_games/"
const EXTENTION_IMAGE_GAME = ".png"

var total_lives = 5
var time_seconds = 120

@onready var title = $TextureRect2/Title
@export var current_lives = 5
@onready var hearts_container = $TextureRect2/HBoxHearts
@onready var difficulty_value = $TextureRect2/HBoxContainer/Difficulty_value
@onready var level_value = $TextureRect2/HBoxContainer2/Level_value
@onready var image_game = $TextureRect2/Sprite2D
@onready var texture_rect = $TextureRect2/Sprite2D/TextureRect
@onready var sentence = $TextureRect2/Sentence
@onready var life_label = $TextureRect2/Life
@onready var temporizador = $TextureRect2/Temporizador
@onready var timer = $TextureRect2/Temporizador/Timer

func _ready():
	sentence.visible = false
	temporizador.visible = false
	timer.stop()
	update_hearts()
	get_parent().connect("update_title", Callable(self, "_on_update_title"))
	get_parent().connect("update_difficulty", Callable(self, "_on_update_difficulty"))
	get_parent().connect("update_level", Callable(self, "_on_update_level"))
	get_parent().connect("uptate_imagen_game", Callable(self, "_on_uptate_imagen_game"))
	get_parent().connect("set_not_visible_image", Callable(self, "_on_set_not_visible_image"))
	get_parent().connect("set_visible_sentence", Callable(self, "_on_set_visible_sentence"))
	get_parent().connect("set_timer", Callable(self, "_on_set_timer"))


func update_hearts():
	for i in range(total_lives):
		var heart = hearts_container.get_child(i)
		if i < current_lives:
			heart.visible = true
		else:
			heart.visible = false

func lose_life():
	if current_lives > 0:
		current_lives -= 1
		update_hearts()

func gain_life():
	if current_lives < total_lives:
		current_lives += 1
		update_hearts()
		

func _on_update_title(new_title):
	title.text = new_title
	
func _on_update_difficulty(new_difficulty):
	difficulty_value.text = new_difficulty
	
func _on_update_level(new_level):
	level_value.text = new_level
	
func _on_uptate_imagen_game(new_image):
	var url_image = PATH_IMAGE_GAME + new_image + EXTENTION_IMAGE_GAME
	texture_rect.texture = load(url_image)

func _on_set_not_visible_image():
	image_game.visible = false
	
func _on_set_visible_sentence(new_sentence):
	sentence.visible = true
	sentence.text = new_sentence
	
func _on_set_timer():
	hearts_container.visible = false
	temporizador.visible = true
	life_label.text = 'Time left'
	timer.start()

func _on_timer_timeout():
	if time_seconds > 0:
		time_seconds -= 1
	else:
		get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")
	temporizador.text = str(time_seconds)

func _on_btn_home_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")
	

	

