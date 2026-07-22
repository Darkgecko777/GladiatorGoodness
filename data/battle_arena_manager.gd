extends Control

@onready var arena_container: Node2D = $MainLayout/RightColumn/ArenaViewport/ArenaContainer

# Persistent bars
@onready var player_health_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/PlayerBars/VBoxContainer/HealthBar
@onready var enemy_health_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/MonsterBars/VBoxContainer/HealthBar

@export var token_scene: PackedScene = preload("res://scenes/Character_Token.tscn")

@export var player_start_offset: Vector2 = Vector2(400, 375)
@export var enemy_start_offset: Vector2 = Vector2(900, 375)

var player_token: CharacterToken
var enemy_token: CharacterToken

@onready var character_manager: Node = $CharacterManager

func _ready():
	setup_battle()

func setup_battle():
	# Clear old tokens
	for child in arena_container.get_children():
		child.queue_free()
	
	
	#player_token = character_manager.create_token_from_template(player_def, true)
	#enemy_token = character_manager.create_token(enemy_def, false)
	
	if not player_token or not enemy_token:
		push_error("BattleArenaManager: Failed to create tokens!")
		return
	
	player_token.position = player_start_offset
	enemy_token.position = enemy_start_offset
	
	arena_container.add_child(player_token)
	arena_container.add_child(enemy_token)
	
	_connect_health_bars()

func _connect_health_bars():
	if player_token and player_token.data:
		player_token.data.health_changed.connect(_on_player_health_changed)
		player_health_bar.max_value = player_token.data.max_health
		player_health_bar.value = player_token.data.current_health
	
	if enemy_token and enemy_token.data:
		enemy_token.data.health_changed.connect(_on_enemy_health_changed)
		enemy_health_bar.max_value = enemy_token.data.max_health
		enemy_health_bar.value = enemy_token.data.current_health

func _on_player_health_changed(new_health: int):
	player_health_bar.value = new_health

func _on_enemy_health_changed(new_health: int):
	enemy_health_bar.value = new_health
