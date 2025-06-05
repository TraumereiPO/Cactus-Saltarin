extends CanvasLayer
var corazon_lleno : Texture
var corazon_vacio : Texture 
func _ready():
	# Carga las texturas desde los archivos (ajusta las rutas a las reales)
	corazon_lleno = load("res://Sprites/Vida_llena-0001.png")
	corazon_vacio = load("res://Sprites/Vida_vacia-0002.png")
func actualizar_vidas(cantidad):
	for i in range(3):
		var sprite = $"HBoxContainer".get_child(i)
		if i < cantidad:
			sprite.texture = corazon_lleno
		else:
			sprite.texture = corazon_vacio
		
