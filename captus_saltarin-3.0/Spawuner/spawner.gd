extends Node2D
const DINOSAUR_SCENE = preload("res://Dinosaurio/dino_body_2d.tscn")
@onready var spawn_timer = $Timer
func _ready(): 
	spawn_timer.wait_time = 3.0
	spawn_timer.start()
	spawn_timer.timeout.conect(_on_timer_timeout)
func _on_timer_timeout():
	var dinosaurio_instance = DINOSAUR_SCENE.instantiate()
	add_child(dinosaurio_instance)
	dinosaurio_instance.position = Vector2(800, 400)
	
