extends CharacterBody2D
const SPEED = -600.0 # Velocidad de salto
const JUMP_VELOCITY = -900.0 # Altura de salto
const GRAVITY = 2000.0 # Aumentar la gravedad para que caiga más rápido
const CROUCH_OFFSET = 10.0
var velocidad = Vector2.ZERO
var is_crouching = false
var defauld_position_y
@onready var animated_sprite = $AnimatedSprite2D
var Vidas = 3

func _ready():
	defauld_position_y = position.y
	animated_sprite.play("reposo")
	$Area2D.connect("body_entered", Callable(self, "_on_area_2d_body_entered"))
func _physics_process(delta):
	#condición
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	# Movimiento de agachar
	if Input.is_action_just_pressed("ui_down") and is_on_floor() and not is_crouching:
			is_crouching = true
			animated_sprite.play("abajo")
			position.y += CROUCH_OFFSET
			
	# Condición: si no esta saltando esta en reposo
	elif Input.is_action_just_released("ui_down") and is_crouching:
		is_crouching = false
		animated_sprite.play("reposo")
		position.y = defauld_position_y
	# salta solo si no esta agachado
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_crouching:
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("saltar")
	move_and_slide() 

func _on_area_2d_body_entered(body):
	if body.is_in_group("jugador"):
		Vidas -= 1 # le quita una vida al cactus cuando un dinosaurio lo atraviesa
		get_node("/root/Level/HUD").actualizar_vidas(Vidas) #Actualiza el estado de las vidas por las vacias
		if Vidas <= 0:
			if not get_tree().current_scene.has_node("PantallaReinicio"):
				var reinicio = load("res://UI/pantalla_reinicio.tscn").instantiate()
				reinicio.name = "PantallaReinicio"
				get_tree().current_scene.add_child(reinicio)
