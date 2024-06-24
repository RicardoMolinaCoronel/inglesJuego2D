extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_btn_puzzle_pressed():
	get_tree().change_scene_to_file("res://Escenas/SeleccionOracion.tscn")


func _on_btn_match_pressed():
	get_tree().change_scene_to_file("res://Escenas/SeleccionUnir.tscn")


func _on_btn_order_pressed():
	get_tree().change_scene_to_file("res://Escenas/SeleccionPalabra.tscn")


func _on_btn_go_back_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")
