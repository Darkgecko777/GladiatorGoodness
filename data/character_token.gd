class_name CharacterToken
extends Sprite2D

@export var data: CharacterData

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	if data:
		if sprite and data.portrait:
			sprite.texture = data.portrait
		update_health_bar()

func update_health_bar():
	if health_bar and data:
		health_bar.max_value = data.max_health
		health_bar.value = data.current_health
