extends Node2D

const PlayerScene = preload("res://Scenes/player.tscn")

var playerSpawnLocation: Vector2 = Vector2.ZERO

@onready var camera: = $Camera2D
@onready var player: Player = $Player
@onready var respawnTimer: Timer = $RespawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.LIGHT_BLUE)
	connect_camera()
	Events.connect("player_died", self._on_player_died)
	playerSpawnLocation = player.global_position

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

func connect_camera():
	player.connect_camera(camera)

func _on_player_died() -> void:
	respawnTimer.start(1.)
	await respawnTimer.timeout
	player = PlayerScene.instantiate() as Player
	player.position = playerSpawnLocation
	add_child(player)
	connect_camera()
