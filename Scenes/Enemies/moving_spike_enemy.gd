@tool
extends Path2D

enum ANIMATION_TYPE {
	LOOP = 0,
	BOUNCE = 1,
}

@onready var animationPlayer: = $AnimationPlayer

@export var animation_type: ANIMATION_TYPE = ANIMATION_TYPE.LOOP:
    set(value): 
        animation_type = value
        if animationPlayer:
          handleAnimationTypeChange()

@export var speed: float = 1:
    set(value): 
        speed = value
        if animationPlayer:
          handleAnimationSpeedChange()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    handleAnimationTypeChange()
    handleAnimationSpeedChange()

func handleAnimationSpeedChange() -> void:
    animationPlayer.speed_scale = speed

func handleAnimationTypeChange() -> void:
    match animation_type:
        ANIMATION_TYPE.LOOP:
            animationPlayer.play("MoveAlongPathLoop")
        ANIMATION_TYPE.BOUNCE:
            animationPlayer.play("MoveAlongPathBounce")