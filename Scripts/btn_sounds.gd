extends Control

const PATH_MUTE_IMAGE = "res://Sprites/buttons/bnt_mute.png"
const PATH_MUSIC_IMAGE = "res://Sprites/buttons/Boton_Musica.png"

var music_bus = AudioServer.get_bus_index("Master")
@onready var texture_button = $TextureButton

func _ready():
	if not AudioServer.is_bus_mute(music_bus):
		texture_button.texture_normal = preload(PATH_MUSIC_IMAGE)
		texture_button.texture_pressed = preload(PATH_MUTE_IMAGE)
	else:
		texture_button.texture_normal = preload(PATH_MUTE_IMAGE)
		texture_button.texture_pressed = preload(PATH_MUSIC_IMAGE)

func _on_texture_button_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))

