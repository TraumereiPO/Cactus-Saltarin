extends CharacterBody2D
# Velocidad del dinosaurio
var speed = 200 #define que tan rapido se movera el dinosaurio
func _physics_process(delta):
	# Mueve el dinosaurio hacia la izquierda
	velocity.x = -speed
	move_and_slide() # Aplica el movimiento de forma fluida
	# Cambia la animación del dinosaurio
	if $AnimatedSprite2D.animation != "correr":
		$AnimatedSprite2D.play("correr")
	
func _ready(): #Area de colision: detecta la colision con otros objetos, como el cactus
	$Area2D.body_entered.connect(_on_area_2d_body_entered) #Asegura que reciba el argumento body
func _on_area_2d_body_entered(body: Node2D):
	if body.name == "Cactus":
		print("colision detectada")
		
	
