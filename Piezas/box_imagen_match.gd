extends Node2D

var value = "a"
@onready var fondo_clic = $Button/Fondo_clic
var blocked = false
@onready var imagen = $Button/imagen
@onready var animation_image = $AnimationImage


# Called when the node enters the scene tree for the first time.
func _ready():
	fondo_clic.visible = false


func put_image(url_path, entry_value):
	imagen.texture = load(url_path)
	value = entry_value


func _on_button_pressed():
	if blocked:
		return
	fondo_clic.visible = true
	get_parent().handle_value_selected(self)
	
func animation_match():
	animation_image.play("Match")

func animation_no_match():
	animation_image.play("No_match")
	

