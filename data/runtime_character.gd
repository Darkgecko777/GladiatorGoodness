class_name RuntimeCharacter
extends Resource

# Identification & Origin
@export var persistent_id: String = ""           # Unique saveable ID
@export var character_id: String = ""            # Link back to template/definition if used
@export var display_name: String = ""
@export var species_or_class: String = ""
@export var is_monster: bool = false

# Primary Attributes (current / trained values)
@export var vitality: int
@export var endurance: int
@export var strength: int
@export var agility: int
@export var precision: int
@export var resilience: int
@export var charisma: int

# Secondary / Derived Stats (base or current)
@export var max_health: int
@export var max_stamina: int
@export var stamina_regen: float
@export var base_damage: int
@export var attack_speed: float
@export var initiative: float
@export var dodge_chance: float
@export var accuracy: float
@export var crit_chance: float
@export var crit_multiplier: float
@export var adaptation: float                     # Current stance commitment
@export var adaptation_rate: float

# Defense & Resistance
@export var primary_damage_reduction: float
@export var secondary_defense_vs_crits: float
@export var status_resistance: float
@export var intimidation_resistance: float

# Crowd & Meta
@export var crowd_influence: float
@export var stance_affinity: float
@export var essence_potency: float

# Progression & State
@export var level: int = 1
@export var experience: int = 0
@export var recruitment_cost: int = 0
@export var current_injuries: int = 0             # Affects training/recovery

# Combat State (current during/after fights)
var current_health: int
var current_stamina: int
var is_alive: bool = true
var current_stance: String = "Neutral"
var stance_timer: float = 0.0

# Signals
signal health_changed(new_health: int)
signal stamina_changed(new_stamina: int)
signal stance_changed(new_stance: String)
signal character_defeated

# Called after creation by generator or factory
func initialize() -> void:
	recalculate_secondaries()
	reset_for_battle()

func recalculate_secondaries() -> void:
	# Core derivations from primaries (expand as needed)
	max_health = 50 + vitality * 8
	max_stamina = 40 + endurance * 6
	# stamina_regen, dodge_chance, crit_chance, etc. calculated here or on the fly
	# Example:
	# dodge_chance = base_dodge_from_agility + modifiers
	# Add more formulas from the vision doc

func reset_for_battle() -> void:
	current_health = max_health
	current_stamina = max_stamina
	is_alive = true
	current_stance = "Neutral"
	stance_timer = 0.0

func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health)
	if current_health <= 0:
		is_alive = false
		character_defeated.emit()

# Helper methods
func get_display_name() -> String:
	return display_name if not display_name.is_empty() else "Unknown Fighter"

# Future: apply_level_up(), apply_injury(), heal(), etc.
