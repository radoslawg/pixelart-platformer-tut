extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)

var timer = 0.0
var hit = 0
var fps_sum = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	if timer >= 1:
		timer = 0.0
		DisplayServer.window_set_title("Pixel Platformer - FPS: " + str(ceil(fps_sum / hit)))
		hit = 0
		fps_sum = 0.0
	else:
		fps_sum += 1 / delta
		hit += 1
	pass
