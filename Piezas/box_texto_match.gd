extends Node2D

var target = "a"
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
	
func put_text(new_text):
	target = new_text
	label.text = target.capitalize()
	
func animation_match():
	animation.play("match")

func animation_no_match():
	animation.play("no_match")

func mark_to_match():
	matched = true

func is_matched() -> bool:
	return matched
	
func animation_pista():
	animation.play("Pista")

func animation_reset():
	blocked = false
	matched = false
	animation.play("RESET")
