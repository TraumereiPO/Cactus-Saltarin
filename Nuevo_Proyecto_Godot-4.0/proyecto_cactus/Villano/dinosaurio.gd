extends CharacterBody2D
# Velocidad del dinosaurio
var speed = 200 #define que tan rapido se movera el dinosaurio
@warning_ignore("unused_parameter")
func _physics_process(delta):
	# Mueve el dinosaurio hacia la izquierda
	velocity.x = -speed
	move_and_slide() # Aplica el movimiento de forma fluida
	# Cambia la animación del dinosaurio
	if $AnimatedSprite2D.animation != "correr":
		$AnimatedSprite2D.play("correr")
		
func _ready(): # Dinosaurio pertenece al grupo "Jugador" 
	add_to_group("jugador") 
	
