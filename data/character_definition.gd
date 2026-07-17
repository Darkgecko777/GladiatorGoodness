class_name CharacterDefinition
extends Resource

@export var character_id: String = "unknown"
@export var display_name: String = "Unnamed Fighter"

# Primary Attributes (Base values)
@export var base_vitality: int = 12
@export var base_endurance: int = 12
@export var base_strength: int = 12
@export var base_agility: int = 12
@export var base_precision: int = 12
@export var base_resilience: int = 12
@export var base_charisma: int = 10

# Stance & Personality
@export var base_adaptation: float = 3.0
@export var combat_personality: String = "Balanced"
@export var noncombat_personality: String = "Neutral"

# Visuals
@export var portrait: Texture2D
@export var sprite_texture: Texture2D

# Combat
@export var abilities: Array[Ability] = []

# Metadata
@export var is_monster: bool = false
@export var species_or_class: String = ""
