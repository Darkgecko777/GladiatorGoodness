extends Control

@onready var arena_container: Node2D = $MainLayout/RightColumn/ArenaViewport/ArenaContainer

# Persistent bars
@onready var player_health_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/PlayerBars/VBoxContainer/HealthBar
@onready var enemy_health_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/MonsterBars/VBoxContainer/HealthBar

# Token scenes (we'll eventually use the base Character_Token.tscn for both)
@export var player_token_scene: PackedScene = preload("res://scenes/Character_Token.tscn")
@export var enemy_token_scene: PackedScene = preload("res://scenes/Character_Token.tscn")

@export var player_start_offset: Vector2 = Vector2(400, 375)
@export var enemy_start_offset: Vector2 = Vector2(900, 375)

var player_token: CharacterToken
var enemy_token: CharacterToken

func _ready():
	setup_test_tokens()

func setup_test_tokens():
	# Clear leftovers
	for child in arena_container.get_children():
		child.queue_free()
	
	# Load definitions (you'll replace with real ones later)
	var player_def = preload("res://resources/test_gladiator.tres") as CharacterDefinition
	var enemy_def = preload("res://resources/minotaur.tres") as CharacterDefinition
	
	# Create runtime data
	var player_data = CharacterData.new()
	player_data.setup_from_definition(player_def)
	
	var enemy_data = CharacterData.new()
	enemy_data.setup_from_definition(enemy_def)
	
	# Instantiate tokens
	player_token = player_token_scene.instantiate() as CharacterToken
	player_token.data = player_data
	player_token.is_player_controlled = true
	arena_container.add_child(player_token)
	player_token.position = player_start_offset
	
	enemy_token = enemy_token_scene.instantiate() as CharacterToken
	enemy_token.data = enemy_data
	enemy_token.is_player_controlled = false
	arena_container.add_child(enemy_token)
	enemy_token.position = enemy_start_offset
	
	# Connect signals to bars
	if player_token and player_token.data:
		player_token.data.health_changed.connect(_on_player_health_changed)
		player_health_bar.max_value = player_data.max_health
		player_health_bar.value = player_data.current_health
	
	if enemy_token and enemy_token.data:
		enemy_token.data.health_changed.connect(_on_enemy_health_changed)
		enemy_health_bar.max_value = enemy_data.max_health
		enemy_health_bar.value = enemy_data.current_health

func _on_player_health_changed(new_health: int):
	player_health_bar.value = new_health

func _on_enemy_health_changed(new_health: int):
	enemy_health_bar.value = new_health
