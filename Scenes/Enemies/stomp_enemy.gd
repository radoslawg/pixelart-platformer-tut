extends Node2D

enum {HOVER, FALL, LAND, RISE}

var state: = HOVER

@onready var start_position: = global_position
@onready var sprite: = $AnimatedSprite2D;
@onready var raycast: = $RayCast2D
@onready var ground_timer: = %Timer
@onready var dust: = %Dust

@export var FALL_SPEED: float = 120.0
@export var RISE_SPEED: float = 30.0
@export var GROUND_TIME: float = 1.0


func _physics_process(delta: float) -> void:
	match state:
		HOVER:
			hover_state(delta)
		FALL:
			fall_state(delta)
		LAND:
			land_state(delta)
		RISE:
			rise_state(delta)


func hover_state(delta: float) -> void:
	state = FALL
	sprite.play("Rising")

func fall_state(delta: float) -> void:
	sprite.play("Falling")
	position.y += FALL_SPEED * delta
	if raycast.is_colliding():
		dust.lifetime = GROUND_TIME * 0.9
		dust.emitting = true
		ground_timer.start(GROUND_TIME)
		SoundPlayer.play_sound(SoundPlayer.STOMP)
		state = LAND

func land_state(delta: float) -> void:
	if (ground_timer.time_left == 0.):
		state = RISE
		dust.emitting = false

func rise_state(delta: float) -> void:
	sprite.play("Rising")
	position.y = move_toward(position.y, start_position.y, RISE_SPEED * delta)
	if position.y == start_position.y:
		state = HOVER

