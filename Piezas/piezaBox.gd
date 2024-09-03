extends Node2D

var occupied = false
var current_node = "none"
@export var letter = "A"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _animacion_pista():
	$AnimationPlayer.play("Pista")

func _on_area_2d_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if !occupied:
		occupied = true
		current_node = area
		area.get_parent().snap_to = position
		area.get_parent().target_letter = letter
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if area == current_node:
		occupied = false
	pass # Replace with function body.

func _reiniciar_variables():
	occupied = false
	current_node = null

