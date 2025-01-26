extends Node

const HURT = preload("res://Audio/Sounds/hurt.wav")
const JUMP = preload("res://Audio/Sounds/jump.wav")

@onready var audioPlayers: = %AudioPlayers.get_children()

func play_sound(sound) -> void:
	for audioStreamPlayer in audioPlayers:
		if not audioStreamPlayer.is_playing():
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
