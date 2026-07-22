extends Node

@export var rules: GladiatorGeneratorRules

func generate_gladiator() -> CharacterTemplate:
	var definition: CharacterTemplate = CharacterTemplate.new()
	
	definition.display_name = rules.create_name()
	definition.base_strength = rules.create_stat()
	definition.base_agility = rules.create_stat()
	definition.base_endurance = rules.create_stat()
	definition.base_charisma = rules.create_stat()
	definition.base_vitality = rules.create_stat()
	definition.base_precision = rules.create_stat()
	definition.base_resilience = rules.create_stat()
	
	return null	 
