class_name CharacterTemplate
extends Resource

# Identification
@export var character_id: String = ""
@export var display_name: String = ""
@export var species_or_class: String = ""
@export var is_alive: bool = true
@export var is_monster: bool = false

# Visuals
@export var visual_key: String = ""

#region Vitality Stats
@export var base_vitality: int
@export var base_max_health: int
@export var base_healing: int
@export var current_health: int
#endregion

#region Endurance Stats
@export var base_endurance: int
@export var base_max_stamina: int
@export var base_stamina_regen: float
@export var current_stamina: int
#endregion

#region Strength Stats
@export var base_strength: int
@export var base_damage: int
#endregion

#region Agility Stats
@export var base_agility: int
@export var base_attack_speed: float
@export var base_initiative: float
@export var base_dodge_chance: float
#endregion

#region Precision Stats
@export var base_precision: int
@export var base_crit_chance: float
@export var base_accuracy: float
#endregion

#region Resislience Stats
@export var base_resilience: int
@export var base_crit_multiplier: float
#endregion

#region Charisma Stats
@export var base_charisma: int
#endregion

#cunning
@export var base_cunning: float         # Stance commitment duration
@export var base_cunning_rate: float    # Fluidity of stance changes

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

# Signals
signal health_changed(new_health: int)
signal stamina_changed(new_stamina: int)
signal stance_changed(new_stance: String)
signal character_defeated

func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)
	if current_health <= 0:
		is_alive = false
		character_defeated.emit()


# Notes / Future fields can go here
# @export var base_training_recovery: float
# @export var base_forging_bonus: float
# etc.
