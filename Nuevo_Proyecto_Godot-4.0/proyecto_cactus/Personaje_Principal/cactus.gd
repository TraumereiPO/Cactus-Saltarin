class_name Personaje
extends CharacterBody2D
const SPEED = 600.0
const JUMP_VELOCITY = -900.0
const GRAVITY = 1600.0
const CROUCH_OFFSET = 10.0
var is_crouching = false
var defauld_position_y
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	defauld_position_y = position.y
	animated_sprite.play("reposo")
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
	if body.name == "Dinosaurio":
		print("¡El dinosaurio chocó con el cactus!")
		
	   
