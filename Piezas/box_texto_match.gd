extends Node2D

@export var target = "a"
@onready var fondo_clic = $Button/Fondo_clic
var blocked = false
@onready var label = $Button/Label
@onready var animation = $Animation
var matched: bool = false

func _ready():
	fondo_clic.visible = false
	label.text = target.capitalize()

func _on_button_pressed():
	if blocked:
		return
	fondo_clic.visible = true
	get_parent().handle_value_match(self)
	
func animation_match():
	animation.play("match")

func animation_no_match():
	animation.play("no_match")

func mark_to_match():
	matched = true

func is_matched() -> bool:
	return matched
