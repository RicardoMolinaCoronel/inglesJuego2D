extends Node2D

var occupied = false
var current_node = "none"
@export var letter = "A"
# Called when the node enters the scene tree for the first time.
func _ready():
	var poligono = $Pista2
	var puntos = poligono.polygon
	var line = $Pista2/Line2D
	line.points = puntos
	line.closed = true
	#line.draw_dashed_line(puntos[0], puntos[puntos.size()-1], Color(1.0,1.0,1.0,1.0), 5.0, 2.0, true )
	#line.draw_dashed_line()
	
	
	
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

