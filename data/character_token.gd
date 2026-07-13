class_name CharacterToken
extends Node2D

@export var data: CharacterData
@export var show_health_bar: bool = true

var health_bar: TextureProgressBar

func _ready():
	setup_health_bar()
	
	if data:
		if has_node("Sprite2D"):
			$Sprite2D.texture = data.portrait
		update_health_bar()

func setup_health_bar():
	if not show_health_bar:
		return
		
	if has_node("HealthBar"):
		health_bar = $HealthBar
	else:
		var health_bar_scene = preload("res://ui/HealthBar.tscn")
		health_bar = health_bar_scene.instantiate()
		health_bar.name = "HealthBar"
		add_child(health_bar)
		if has_node("Sprite2D"):
			var sprite = $Sprite2D
			health_bar.position = Vector2(0, -sprite.texture.get_height() / 2)

func update_health_bar():
	if health_bar and data:
		health_bar.max_value = data.max_health
		health_bar.value = data.current_health
	else:
		print("HealthBar not ready for ", name)
