extends Area2D

@export_file("*.tscn") var target_level_scene; 


func _on_body_entered(body:Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file(target_level_scene)
