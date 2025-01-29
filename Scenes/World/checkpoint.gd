extends Area2D

@onready var _sprite:AnimatedSprite2D = $AnimatedSprite2D

func _on_body_entered(body:Node2D) -> void:
	print_debug("Checkpoint reached")
	if not body is Player: return
	_sprite.play("checked")
	Events.emit_signal("checkpoint_reached", position)
