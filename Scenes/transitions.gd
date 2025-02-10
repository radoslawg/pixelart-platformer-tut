extends Node

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

signal transition_completed

func play_exit_transition():
	animationPlayer.play("ExitLevel")

func play_enter_transition():
	animationPlayer.play("EnterLevel")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	emit_signal("transition_completed")
	pass # Replace with function body.
