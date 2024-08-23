extends Node2D

@export var target = "a"
@onready var fondo_clic = $Button/Fondo_clic
var blocked = false
@onready var label = $Button/Label
@onready var animation = $Animation


# Called when the node enters the scene tree for the first time.
func _ready():
	fondo_clic.visible = false
	label.text = target.capitalize()


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_button_pressed():
	if blocked:
		return
	fondo_clic.visible = true
	get_parent().handle_value_match(self)
	
func animation_match():
	animation.play("match")

func animation_no_match():
	animation.play("no_match")
