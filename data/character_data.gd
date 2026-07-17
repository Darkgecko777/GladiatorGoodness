class_name CharacterData
extends Resource

# Reference to the base template
@export var definition: CharacterDefinition

# Persistent reference (for saving progress)
@export var persistent_id: String = ""

# Primary Attributes (runtime copies)
var vitality: int = 12
var endurance: int = 12
var strength: int = 12
var agility: int = 12
var precision: int = 12
var resilience: int = 12
var charisma: int = 10

# Secondary / Derived Stats (calculated or modified)
var max_health: int = 100
var current_health: int = 100

var max_stamina: int = 100
var current_stamina: int = 100

var adaptation: float = 3.0  # Current stance commitment time

# Combat state
var is_alive: bool = true
var current_stance: String = "Neutral"
var stance_timer: float = 0.0

# Signals
signal health_changed(new_health: int)
signal stamina_changed(new_stamina: int)
signal stance_changed(new_stance: String)

func setup_from_definition(def: CharacterDefinition) -> void:
	definition = def
	if not definition:
		return
	
	# Copy primaries
	vitality = definition.base_vitality
	endurance = definition.base_endurance
	strength = definition.base_strength
	agility = definition.base_agility
	precision = definition.base_precision
	resilience = definition.base_resilience
	charisma = definition.base_charisma
	adaptation = definition.base_adaptation
	
	# Calculate initial secondaries
	recalculate_secondaries()
	reset_for_battle()

func recalculate_secondaries() -> void:
	max_health = 50 + vitality * 8
	max_stamina = 40 + endurance * 6
	# Add more derived formulas here as we expand

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

# Helper to get display name
func get_display_name() -> String:
	return definition.display_name if definition else "Unknown"
