extends CharacterBody2D
const SPEED = -300.0
@onready var animated_sprite = $"DinosaurioPng-150x150"
func _ready():
	animated_sprite.play("Run")
	
func _physics_process(delta):
	velocity.x = SPEED
	move_and_slide() 
	if position.x < -100:
		queue_free()
	
func _on_Area2D_body_entered(body):
	print("collision detectada con:", body.name)
	if body.name == "Personaje_Principal":
		body._on_dinosaur_collision()
