extends Node2D
@export var letter = "A"
var dragging = false
var originalpos = Vector2(10,10)
var snap_to = Vector2(0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	originalpos = global_position
	$"InteractivoLetra(vacio)/Label".text = letter
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if dragging:
		position = get_global_mouse_position()
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
	else:
		position = originalpos
	
	pass 
