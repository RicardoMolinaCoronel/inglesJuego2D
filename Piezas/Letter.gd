extends Node2D
@export var letter = "A"
var dragging = false
var originalpos = Vector2(10,10)
var snap_to = Vector2(0,0)
var target_letter = "A"
var correct = false
# Called when the node enters the scene tree for the first time.
func _ready():
	originalpos = global_position
	$"InteractivoLetra(vacio)/Label".text = letter
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging:
		position = get_global_mouse_position()
		correct = false
		$AnimationPlayer.play("RESET")
	pass

func _get_drag_data(_at_position):
	print("arrastando")

func _on_button_button_down():
	dragging = true
	self.move_to_front()
	pass 

func _on_button_button_up():
	dragging = false
	if position.distance_to(snap_to)<45:
		position = snap_to
		if letter == target_letter:
			$AnimationPlayer.play("Correcto")
			correct = true
		else:
			$AnimationPlayer.play("Incorrecto")
			await $AnimationPlayer.animation_finished
			position = originalpos
			correct = false
			Score.perfectBonus= false
	else:
		position = originalpos
	
	pass 
