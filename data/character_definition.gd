class_name CharacterDefinition
extends Resource

@export var character_id: String = "unknown"
@export var display_name: String = "Unnamed Fighter"

# Basic Stats (base values)
@export var base_max_health: int = 100
@export var base_strength: int = 15
@export var base_defense: int = 8
@export var base_speed: int = 10

# Visuals
@export var portrait: Texture2D
@export var sprite_texture: Texture2D
# @export var animations: AnimationPlayer or PackedScene later

# Combat
@export var abilities: Array[Ability] = []

# Metadata
@export var is_monster: bool = false
@export var species_or_class: String = ""  # e.g. "Minotaur" or "Swordsman"
