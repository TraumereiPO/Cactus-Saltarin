extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -900.0
const GRAVITY = 1600.0
const CROUCH_OFFSET = 10.0
var is_crouching = false
var defauld_position_y
@onready var animated_sprite = $AnimatedSprite
@onready var Hub_Vidas = get_node("/res://Scena_Principal/hub_vidas.gd")
var lives = 3

func _ready():
	defauld_position_y = position.y
	animated_sprite.play("reposo")
	$Area2D.connect("body_entered", Callable(self, "_on_body_entered"))
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	#manejo del agachado
	if Input.is_action_just_pressed("ui_down") and is_on_floor() and not is_crouching:
			is_crouching = true
			animated_sprite.play("Agachar")
			position.y += CROUCH_OFFSET
			
	elif Input.is_action_just_released("ui_down") and is_crouching:
		is_crouching = false
		animated_sprite.play("reposo")
		position.y = defauld_position_y
	# salta solo si no esta agachado
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and not is_crouching:
		velocity.y = JUMP_VELOCITY
		animated_sprite.play("Saltar")

	move_and_slide() 
	
func _on_dinosaour_colision():
	lives -= 1
	print("¡El Cactus perdio una vida! Vidas restantes:", lives)
	Hub_Vidas.reduce_life()
	if lives <= 0:
		_game_over()
func _game_over():
	print("¡Juego terminado!")
	get_tree().change_scene_to_file("res://Fondo_de_Retorno/pantalla_reinicio.tscn")
