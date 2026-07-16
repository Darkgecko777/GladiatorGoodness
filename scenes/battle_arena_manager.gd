# scenes/battle_arena_manager.gd
extends Control

@onready var arena_container: Node2D = $MainLayout/RightColumn/ArenaViewport/ArenaContainer
@onready var player_health_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/PlayerBars/VBoxContainer/HealthBar
@onready var player_stamina_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/PlayerBars/VBoxContainer/StaminaBar
@onready var enemy_health_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/MonsterBars/VBoxContainer/HealthBar
@onready var enemy_stamina_bar: TextureProgressBar = $MainLayout/RightColumn/ArenaViewport/MonsterBars/VBoxContainer/StaminaBar

@export var player_token_scene: PackedScene = preload("res://scenes/player_token.tscn")
@export var enemy_token_scene: PackedScene = preload("res://scenes/minotaur.tscn")

@export var player_start_offset: Vector2 = Vector2(300, 400)
@export var enemy_start_offset: Vector2 = Vector2(1100, 400)

var player_token: CharacterToken
var enemy_token: CharacterToken

func _ready():
	setup_test_tokens()

func setup_test_tokens():
	# Clear anything leftover
	for child in arena_container.get_children():
		child.queue_free()
	
	# Instantiate Player
	if player_token_scene:
		player_token = player_token_scene.instantiate() as CharacterToken
		if player_token:
			player_token.is_player_controlled = true
			arena_container.add_child(player_token)
			player_token.position = player_start_offset
			print("Player token instantiated at ", player_start_offset)
	
	# Instantiate Enemy
	if enemy_token_scene:
		enemy_token = enemy_token_scene.instantiate() as CharacterToken
		if enemy_token:
			enemy_token.is_player_controlled = false
			arena_container.add_child(enemy_token)
			enemy_token.position = enemy_start_offset
			print("Enemy token instantiated at ", enemy_start_offset)

func _process(_delta):  # Temporary for testing
	if player_token and enemy_token:
		# They should now fight each other using existing logic
		pass
