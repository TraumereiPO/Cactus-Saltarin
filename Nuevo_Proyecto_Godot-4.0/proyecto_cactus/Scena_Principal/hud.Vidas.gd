extends CanvasLayer
var corazon_lleno : Texture
var corazon_vacio : Texture 
var tiempo_jugado = 0
var record_tiempo = 0
var velocidad_acelerada_aplicada = false
# llama a los nodos hijos label y timer para ser usados en el codigo
@onready var label_tiempo = $LabelTiempo
@onready var label_record = $LabelRecord
@onready var timer = $TemporizadorJuego

func _ready():
	cargar_record()
	timer.start()
	actualizar_label()
	# Carga las texturas desde los archivos
	corazon_lleno = load("res://Sprites/Vida_llena-0001.png")
	corazon_vacio = load("res://Sprites/Vida_vacia-0002.png")
	
func actualizar_vidas(cantidad): #Cuando se le resta una vida, actualiza su estado de lleno a vacio
	for i in range(3):
		var sprite = $"HBoxContainer".get_child(i)
		if i < cantidad:
			sprite.texture = corazon_lleno
		else:
			sprite.texture = corazon_vacio
			
func _on_temporizador_juego_timeout(): # Temporizador
	tiempo_jugado += 1 # suma un segundo cada vez que el temporizador hace "timeout".
	
	if tiempo_jugado > record_tiempo:
		record_tiempo = tiempo_jugado
		guardar_record() # se guarda el nuevo récord siempre que lo superes.
		if not velocidad_acelerada_aplicada:
			velocidad_acelerada_aplicada = true
			acelerar_dinosaurios() # solo se llama una vez, cuando superas el récord por primera vez.
	actualizar_label() # muestra el nuevo tiempo en pantalla.
func actualizar_label():
	var minutos = tiempo_jugado / 60 
	var segundos = tiempo_jugado % 60
	label_tiempo.text = "Tiempo: %02d:%02d" % [minutos, segundos]
	var minutos_record = record_tiempo / 60
	var segundos_record = record_tiempo % 60
	label_record.text = "Récord: %02d:%02d" % [minutos_record, segundos_record]
func guardar_record():
	var file = FileAccess.open("user://record.save", FileAccess.WRITE)
	file.store_32(record_tiempo)
	file.close()
func cargar_record():
	if FileAccess.file_exists("user://record.save"):
		var file = FileAccess.open("user://record.save", FileAccess.READ)
		record_tiempo = file.get_32() 
		file.close()
func acelerar_dinosaurios():
	var enemigos = get_tree().get_nodes_in_group("Dinosaurios")
	for dino in enemigos:
		dino.multiplicar_velocidad(3) # Aumento de velocidad
