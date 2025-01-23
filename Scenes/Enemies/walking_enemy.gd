extends CharacterBody2D

var direction = Vector2.RIGHT
var vel = Vector2.ZERO

@onready var ledgeCheck := $LedgeCheck
@onready var sprite := $AnimatedSprite2D
# func _on_ready() -> void:

func _physics_process(delta: float) -> void:
	var found_ledge = not ledgeCheck.is_colliding()
	
	sprite.play("Walking")
	# Add the gravity.
	# if not is_on_floor():
	# 	velocity += get_gravity() * delta

	if is_on_wall() or found_ledge:
		direction *= -1
		ledgeCheck.position.x *= -1

	velocity.x = direction.x * 25

	if direction == Vector2.RIGHT:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	move_and_slide()
