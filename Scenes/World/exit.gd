extends Area2D

@export_file("*.tscn") var target_level_scene; 

var player: CharacterBody2D

func go_to_next_room():
	var tree = get_tree()
	tree.paused = true
	Transitions.play_exit_transition()
	await(Transitions.transition_completed)
	get_tree().change_scene_to_file(target_level_scene)
	Transitions.play_enter_transition()
	tree.paused = false

func _process(delta):
	if not player or not player.is_on_floor(): return
	if Input.is_action_just_pressed("ui_up"):
		go_to_next_room()

func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		player = body
		player.on_door = true

func _on_body_exited(body:Node2D) -> void:
	if body is Player:
		player.on_door = false
		player = null
