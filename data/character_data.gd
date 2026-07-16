# data/character_data.gd
class_name CharacterData
extends Resource
signal health_changed(new_health: int)

@export var display_name: String = "Gladiator"
@export var portrait: Texture2D

# Core Stats
@export var max_health: int = 100
@export var current_health: int = 100
@export var strength: int = 15
@export var defense: int = 8
@export var speed: int = 10

# Combat timing (shared for player & monsters)
@export var base_attack_cooldown: float = 1.5  # Seconds - will be scaled by speed

# Future modular stuff
@export var abilities: Array[Ability] = []  # We'll create Ability soon

# Runtime state (not exported)
var current_cooldown: float = 0.0
var is_alive: bool = true

func _init():
	current_cooldown = base_attack_cooldown
	is_alive = true

func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)
	if current_health <= 0:
		is_alive = false

func reset_for_battle() -> void:
	current_health = max_health
	current_cooldown = base_attack_cooldown
	is_alive = true
	
