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
	get_parent().get_parent().connect("update_phrase", Callable(self, "_on_update_phrase"))
	pass # Replace with function body.


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
			await $AnimationPlayer.animation_finished
			correct = true
		else:
			$AnimationPlayer.play("Incorrecto")
			await $AnimationPlayer.animation_finished
			position = originalpos
			correct = false
	else:
		position = originalpos
	
	pass

func _on_update_phrase():
	originalpos = global_position
	$"InteractivoLetra(vacio)/Label".text = letter

func _animacion_pista():
	$AnimationPlayer.play("Pista")

func _animacion_finalizado():
	$AnimationPlayer.play("Final")
	await $AnimationPlayer.animation_finished

func _animacion_retorno():
	$AnimationPlayer.play("Retorno")

func _reiniciar_variables():
	originalpos = Vector2(10,10)
	snap_to = Vector2(0,0)
	correct = false
	

