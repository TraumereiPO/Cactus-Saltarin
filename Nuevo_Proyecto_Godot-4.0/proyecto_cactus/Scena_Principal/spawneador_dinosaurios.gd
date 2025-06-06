extends Node2D

@export var dino_escena: PackedScene # Esto llama a la escena del dinosaurio
@export var posicion_spawn: Vector2 = Vector2(1400, 450) # La posición donde debe aparecer

func _on_timer_spawn_timeout(): # Genera nuevos enemigos
	var nuevo_dino = dino_escena.instantiate()
	get_parent().add_child(nuevo_dino)
	nuevo_dino.global_position = posicion_spawn
