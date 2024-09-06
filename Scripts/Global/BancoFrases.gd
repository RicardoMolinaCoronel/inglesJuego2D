extends Node
var palabrasEsp = [
["El juega fútbol muy bien" , "El patea muy fuerte"], 
["Yo leo la hoja"], 
["Ella barre el piso"],
["Ellos cantan una canción", "Nosotros cantamos juntos"],
["Él trabaja en su computadora"],
["Te gusta jugar golf"], 
["Yo juego con mi perro"], 
["Mario enseña matemáticas"], 
["Él hombre está paseando a su perro"], 
["Él está pescando varios peces"],
]
var cadenas = [
	[["He plays", "football", "very well"], ["He hits", "the ball", "very hard"]],
	[["I read", "the", "paper"]],
	[["She", "sweeps", "the floor"]],
	[["They", "sing", "a song"], ["We", "sing", "together"]],
	[["He works", "on his", "computer"]],
	[["You", "like to", "play golf"]],
	[["I play", "with", "my dog"]],
	[["Mario", "teaches", "maths"]],
	[["The man", "is walking", "his dog"]],
	[["He is", "catching", "some fish"]],
	]
var cadenasOrdenadas = cadenas.duplicate(true)
var images = ["futbol1", "leehoja", "barre", "cantan", "compu", "golf", "juegaperro", "mates", "pasea", "pesca"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


