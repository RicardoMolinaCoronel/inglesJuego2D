extends Node2D
@onready var barraVelocidad = $BarraVelocidad
@onready var barraPrecision = $BarraPrecision
@onready var barraNiveles = $BarraNiveles
var velocidad = 0
var precision = 0
var niveles = 0
var maximoVelocidad = 1000
var maximoPrecision = 1000
var maximoNiveles = 1000
var maximoScaleX = 0.256
enum ventana {PUZZLE = 0, MATCH = 1, ORDER = 2}
var ventanaActual = ventana.PUZZLE
var posActual = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$RetrocederButton.visible = false
	#Leer archivo
	_leer_archivo()	
	_actualizar_valores()	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _leer_archivo():
	velocidad = randi() % 1001
	precision = randi() % 1001
	niveles = randi() % 1001
	
func _actualizar_valores():
	var posVelInicio = barraVelocidad.position.x - (barraVelocidad.scale.x * barraVelocidad.texture.get_size().x * 0.5)
	barraVelocidad.scale.x = (float(velocidad)/float(maximoVelocidad)) * float(maximoScaleX)
	var posVelDespues = posVelInicio + (barraVelocidad.scale.x * barraVelocidad.texture.get_size().x * 0.5)
	barraVelocidad.position.x = posVelDespues
	
	var posPInicio = barraPrecision.position.x - (barraPrecision.scale.x * barraPrecision.texture.get_size().x * 0.5)
	barraPrecision.scale.x = (float(precision)/float(maximoPrecision)) * float(maximoScaleX)
	var posPDespues = posPInicio + (barraPrecision.scale.x * barraPrecision.texture.get_size().x * 0.5)
	barraPrecision.position.x = posPDespues
	
	var posNInicio = barraNiveles.position.x - (barraNiveles.scale.x * barraNiveles.texture.get_size().x * 0.5)
	barraNiveles.scale.x = (float(niveles)/float(maximoNiveles)) * float(maximoScaleX)
	var posNDespues = posNInicio + (barraNiveles.scale.x * barraNiveles.texture.get_size().x * 0.5)
	barraNiveles.position.x = posNDespues
	
	$VelocidadPuntaje.text = str(velocidad)
	$PrecisionPuntaje.text = str(precision)
	$NivelesPuntaje.text = str(niveles)
	$PuntajeTotal.text = str(velocidad+precision+niveles)
	match ventanaActual:
		ventana.PUZZLE:
			$MinijuegoNombre.text = "Puzzle"
		ventana.MATCH:
			$MinijuegoNombre.text = "Match it"
		ventana.ORDER:
			$MinijuegoNombre.text = "Order it"		
			

 # Replace with function body.
func _on_siguiente_button_pressed():
	ButtonClick.button_click()
	ventanaActual += 1
	if(ventanaActual == ventana.ORDER):
		$SiguienteButton.visible = false
	if(ventanaActual > 0):
		$RetrocederButton.visible = true
	_leer_archivo()
	_actualizar_valores()
	pass # Replace with function body.


func _on_retroceder_button_pressed():
	ButtonClick.button_click()
	ventanaActual -= 1
	if(ventanaActual == ventana.MATCH):
		$SiguienteButton.visible = true
	if(ventanaActual == ventana.PUZZLE):
		$RetrocederButton.visible = false
	_leer_archivo()
	_actualizar_valores()
	pass # Replace with function body.


func _on_salir_button_pressed():
	ButtonClick.button_click()
	get_tree().change_scene_to_file("res://Escenas/menu_principal.tscn")
	pass # Replace with function body.
