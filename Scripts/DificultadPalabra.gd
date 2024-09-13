extends Node2D
signal update_scene(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	emit_signal("update_scene", "menu_juegos")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_btn_go_back_pressed():
	get_tree().change_scene_to_file("res://Escenas/menu_juegos.tscn")

func _on_texture_button_pressed():
	ButtonClick.button_click()
	Score.actualDifficult = Score.difficult["easy"]
	get_tree().change_scene_to_file("res://Escenas/Games/OrderEasy1.tscn")


func _on_texture_button_2_pressed():
	ButtonClick.button_click()
	Score.actualDifficult = Score.difficult["medium"]
	get_tree().change_scene_to_file("res://Escenas/Games/OrderEasy1.tscn")


func _on_texture_button_3_pressed():
	ButtonClick.button_click()
	Score.actualDifficult = Score.difficult["hard"]
	get_tree().change_scene_to_file("res://Escenas/Games/OrderEasy1.tscn")
