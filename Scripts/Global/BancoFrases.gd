extends Node
var palabrasEsp = [
["Él juega fútbol muy bien" , "Él patea muy fuerte"], 
["Yo leo la hoja", "Él lee la hoja"], 
["Ella barre el piso", "Ella limpia la casa"],
["Ellos cantan una canción", "Nosotros cantamos juntos"],
["Él trabaja en su computadora", "Él trabaja en la oficina"],
["Te gusta jugar golf", "A él le encanta jugar golf"], 
["Yo juego con mi perro", "Él juega con su perro"], 
["Mario enseña matemáticas", "Él está enseñando matemáticas"], 
["El hombre está paseando a su perro", "Él pasea a su perro"], 
["Él está pescando varios peces", "A él le gusta pescar"],
]
var cadenas = [
	[["He plays", "football", "very well"], ["He hits", "the ball", "very hard"]],
	[["I read", "the", "paper"], ["He reads", "the", "paper"]],
	[["She", "sweeps", "the floor"], ["She", "cleans", "the house"]],
	[["They", "sing", "a song"], ["We", "sing", "together"]],
	[["He works", "on his", "computer"], ["He works", "at the", "office"]],
	[["You", "like to", "play golf"], ["He loves", "to play", "golf"]],
	[["I play", "with", "my dog"], ["He plays", "with", "his dog"]],
	[["Mario", "teaches", "math"], ["He is", "teaching", "math"]],
	[["The man", "is walking", "his dog"], ["He", "walks his", "dog"]],
	[["He is", "catching", "some fish"], ["He", "likes to", "fish"]],
	]
var cadenasOrdenadas = cadenas.duplicate(true)
var images = ["futbol1", "leehoja", "barre", "cantan", "compu", "golf", "juegaperro", "mates", "pasea", "pesca"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


