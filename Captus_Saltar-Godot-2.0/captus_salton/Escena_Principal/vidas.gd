extends Node2D
@onready var hearts = [$"Vida-0001",$"Vida-0002",$"Vida-0003"]
var lives = 3 
func update_hearts():
	for i in range(3):
		if i < lives:
			hearts[i].texture = load("res://Sprites/Vida-0001.png")
		else:
			hearts[i].texture = load("res://Sprites/Vida-0002.png")
func reduce_life():
	lives -= 1 
	update_hearts()
	print("Vidas restantes:", lives)
	
	if lives <=0:
		_game_over()
		
func _game_over():
	print("¡Juego Terminado!")
	get_tree().change_scene_to_file("res://Escena_secundaria/reinicio_del_juego.tscn")
