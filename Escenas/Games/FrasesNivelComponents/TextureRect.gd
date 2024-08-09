extends TextureRect
const STYLE_WORDS = "res://styles/FrasesNivelCorrectos.tres"
#func _get_drag_data(at_position):
	#return [child
func update_container_button(name):
	var button = Button.new()
	button.text = name
	var estilo = preload(STYLE_WORDS)
	#var tema = set_style(estilo)
	button.theme = estilo
	#button.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(button)
	button.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT, Control.PRESET_MODE_KEEP_SIZE)
	
func _can_drop_data(at_position, data):
	return true
	
	
func _drop_data(at_position, data):
	var target_button = get_node("../../DisordenateHBoxContainer/"+name)
	if not _is_valid_drop_area(position, data):
		target_button.visible = true
	else:
		update_container_button(data[0])
		target_button.visible = false
	
func _is_valid_drop_area(position, data):
	if data[1] == name:
		return true
	else:
		return false


func set_style(estilo):
	var tema = Theme.new()
	tema.set_stylebox('disabled', "Button", estilo.get_stylebox("normal", "Button"))
	#tema.set_stylebox('hover', "Button",  estilo.get_stylebox("hover", "Button"))
	#tema.set_stylebox('pressed', "Button",  estilo.get_stylebox("pressed", "Button"))
	#tema.set_stylebox('focus', "Button",  estilo.get_stylebox("focus", "Button"))
	tema.set_font("font", "Button", estilo.get_font("font", "Button"))
	tema.set_font_size("font_size", "Button", estilo.get_font_size("font_size", "Button"))
	tema.set_color("font_color", "Button", estilo.get_color("font_color", "Button"))
	tema.set_color("font_focus_color", "Button", estilo.get_color("font_focus_color", "Button"))
	#tema.set_color("font_hover_color", "Button", estilo.get_color("font_hover_color", "Button"))
	#tema.set_color("font_hover_pressed_color", "Button", estilo.get_color("font_hover_pressed_color", "Button"))
	#tema.set_color("font_outline_color", "Button", estilo.get_color("font_outline_color", "Button"))
	tema.set_color("font_pressed_color", "Button", estilo.get_color("font_pressed_color", "Button"))
	return tema
	
