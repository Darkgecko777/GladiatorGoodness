class_name CharacterData
extends Resource

# NEW: Reference to the base definition/template
@export var definition: CharacterDefinition

# Runtime stats (modified by gear, buffs, current state)
@export var current_health: int = 100
var max_health: int = 100   # Will be set from definition

@export var strength: int = 15
@export var defense: int = 8
@export var speed: int = 10
@export var abilities: Array[Ability] = []

# Combat state
var is_alive: bool = true
var current_cooldown: float = 0.0

# Signal for UI / arena (clean decoupling)
signal health_changed(new_health: int)

func _init():
	reset_for_battle()

# NEW: Setup from definition
func setup_from_definition(def: CharacterDefinition) -> void:
	definition = def
	if definition:
		max_health = definition.base_max_health
		strength = definition.base_strength
		defense = definition.base_defense
		speed = definition.base_speed
		# Add more copying as needed (portrait, abilities later)

func reset_for_battle() -> void:
	if definition:
		current_health = definition.base_max_health
	else:
		current_health = max_health
	is_alive = true
	current_cooldown = 1.5  # default, can scale by speed later

func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)
	if current_health <= 0:
		is_alive = false

# Helper to get display name
func get_display_name() -> String:
	return definition.display_name if definition else "Unknown"
