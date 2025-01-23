extends CharacterBody2D

class_name Player

enum {
	MOVE,
	CLIMB
}

@export var SPEED = 100.0
@export var ACCELERATION = 5.0
@export var DEACCELERATION = 15.0
@export var JUMP_VELOCITY = 300.0
@export var SMALL_JUMP_VELOCITY = 40.0
@export var FAST_FALL_SPEED = 200.0

@onready var _sprite = $AnimatedSprite2D
@onready var ladderCheck = $LadderCheck

var fast_fall = false
var state = MOVE

func _physics_process(delta: float) -> void:
	match state:
		MOVE:
			move_state(delta)
		CLIMB:
			climb_state()
	
	move_and_slide()

func handle_input():

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if sign(direction) != sign(velocity.x):
			velocity.x = 0
		_sprite.flip_h = direction >= 0
		velocity.x = move_toward(velocity.x, direction * SPEED, ACCELERATION)
		_sprite.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, DEACCELERATION)
		if is_on_floor():
			_sprite.play("Idle")

func handle_jump():
	if is_on_floor():
		fast_fall = false
		if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")):
			velocity.y = -JUMP_VELOCITY
	else:
		_sprite.play("Jump")
		if (Input.is_action_just_released("ui_accept") or Input.is_action_just_released("ui_up")) and velocity.y < -SMALL_JUMP_VELOCITY:
			velocity.y = -SMALL_JUMP_VELOCITY
		if velocity.y > 0 and not fast_fall:
			fast_fall = true
			velocity.y += FAST_FALL_SPEED

func apply_gravity(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func is_on_ladder() -> bool:
	if not ladderCheck.is_colliding(): return false
	var collider = ladderCheck.get_collider()
	if not collider is Ladder: return false
	return true

func move_state(delta: float) -> void:
	if is_on_ladder() and Input.is_action_pressed("ui_up"):
		state = CLIMB

	apply_gravity(delta)
	handle_jump()
	handle_input()

func climb_state() -> void:
	if not is_on_ladder():
		state = MOVE
	var vertical_dir := Input.get_axis("ui_up", "ui_down")
	velocity.y = vertical_dir * 50.0
	handle_input()
	if velocity.y != 0.0:
		_sprite.play("Run")
	else:
		_sprite.play("Idle")
