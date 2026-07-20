class_name CharacterDefinition
extends Resource

# Identification
@export var character_id: String = ""
@export var display_name: String = ""
@export var species_or_class: String = ""

# Primary Attributes (Base values)
@export var base_vitality: int
@export var base_endurance: int
@export var base_strength: int
@export var base_agility: int
@export var base_precision: int
@export var base_resilience: int
@export var base_charisma: int

# Secondary / Derived Base Values
# These represent starting points, modifiers, or base calculations that the runtime character will use/expand
@export var base_max_health: int
@export var base_max_stamina: int
@export var base_stamina_regen: float
@export var base_damage: int               # or base_ability_power
@export var base_attack_speed: float
@export var base_initiative: float
@export var base_dodge_chance: float
@export var base_accuracy: float
@export var base_crit_chance: float
@export var base_crit_multiplier: float
@export var base_adaptation: float         # Stance commitment duration
@export var base_adaptation_rate: float    # Fluidity of stance changes

# Defense & Resistance Secondaries
@export var base_primary_damage_reduction: float   # Gear-influenced, diminishing returns
@export var base_secondary_defense_vs_crits: float # From Resilience
@export var base_status_resistance: float
@export var base_intimidation_resistance: float

# Crowd & Personality Influence
@export var base_crowd_influence: float            # Hype generation
@export var base_stance_affinity: float            # Trigger weighting (modulated by personality + Charisma)

# Meta / Special
@export var base_essence_potency: float

# Personality Traits
@export var combat_personality: String      # e.g. "Aggressive", "Defensive", "Balanced", "Cunning"
@export var noncombat_personality: String

# Visuals & Assets
@export var portrait: Texture2D
@export var sprite_texture: Texture2D

# Combat Abilities
@export var abilities: Array[Ability] = []

# Metadata
@export var is_monster: bool = false
@export var is_unique: bool = false

# Notes / Future fields can go here
# @export var base_training_recovery: float
# @export var base_forging_bonus: float
# etc.
