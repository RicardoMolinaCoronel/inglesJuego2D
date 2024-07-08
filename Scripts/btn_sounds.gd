extends Control

var music_bus = AudioServer.get_bus_index("Master")



func _on_texture_button_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
