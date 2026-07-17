class_name PersistentCharacter
extends Resource

@export var persistent_id: String = ""
@export var definition: CharacterDefinition

@export var display_name: String = "Unnamed Fighter"
@export var level: int = 1
@export var experience: int = 0

# Primary stats (can be modified over time)
@export var vitality: int = 12
@export var endurance: int = 12
@export var strength: int = 12
@export var agility: int = 12
@export var precision: int = 12
@export var resilience: int = 12
@export var charisma: int = 10

@export var adaptation: float = 3.0

# Personality
@export var combat_personality: String = "Balanced"
@export var noncombat_personality: String = "Neutral"

# Equipment & State
@export var equipped_weapon: Resource  # Will be EssenceWeapon later
@export var is_monster: bool = false
@export var species_or_class: String = ""

# Metadata
@export var recruitment_cost: int = 100
@export var current_injuries: int = 0  # For future training penalties

func create_from_definition(def: CharacterDefinition) -> void:
	definition = def
	if not definition:
		return
	
	persistent_id = str(randi()) + "_" + def.character_id
	display_name = def.display_name
	is_monster = def.is_monster
	species_or_class = def.species_or_class
	
	# Copy base stats
	vitality = def.base_vitality
	endurance = def.base_endurance
	strength = def.base_strength
	agility = def.base_agility
	precision = def.base_precision
	resilience = def.base_resilience
	charisma = def.base_charisma
	adaptation = def.base_adaptation
	
	combat_personality = def.combat_personality
	noncombat_personality = def.noncombat_personality

# Helper to create runtime data
func create_runtime_data() -> CharacterData:
	var data = CharacterData.new()
	data.persistent_id = persistent_id
	data.setup_from_definition(definition)
	# Future: apply level bonuses, equipment, injuries here
	return data
