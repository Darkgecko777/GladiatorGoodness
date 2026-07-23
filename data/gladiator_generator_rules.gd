class_name GladiatorGeneratorRules
extends Resource

## Data-driven generation policy for human gladiators.
## Formulas match the locked design in gladiator_generation_rules.md.

@export var id_prefix: String = "GLD"
@export var default_species: String = "Human"
@export var default_visual_key: String = "placeholder_gladiator"

## Running counter — normally owned by GuildState; kept here as a fallback for standalone tests.
var _next_id_number: int = 1

const COMBAT_PERSONALITIES: Array[String] = [
	"Aggressive", "Defensive", "Balanced", "Cunning", "Showman", "Reckless"
]

const NONCOMBAT_PERSONALITIES: Array[String] = [
	"Loyal", "Ambitious", "Stoic", "Volatile", "Gregarious", "Solitary"
]

## Weighted 0–12 distribution (~5% at each extreme, peak in the middle).
## Pairs of [value, weight]. Weights are relative.
const PRIMARY_WEIGHTS: Array = [
	[0, 5], [1, 6.5], [2, 8], [3, 9], [4, 10],
	[5, 11.5], [6, 12], [7, 11.5],
	[8, 10], [9, 9], [10, 8], [11, 6.5], [12, 5]
]


func create_name() -> String:
	return GladiatorNameData.pick_random_name(false)


func create_character_id() -> String:
	var id := "%s-%04d" % [id_prefix, _next_id_number]
	_next_id_number += 1
	return id


## Allow GuildState (or tests) to seed / sync the counter.
func set_next_id_number(value: int) -> void:
	_next_id_number = maxi(1, value)


func get_next_id_number() -> int:
	return _next_id_number


func create_primary_stat() -> int:
	## Returns final primary in 8–20 (0–12 roll + 8).
	var roll := _weighted_primary_roll()
	return roll + 8


func create_cunning() -> float:
	## Flat random 2–10 inclusive.
	return float(randi_range(2, 10))


func create_combat_personality() -> String:
	return COMBAT_PERSONALITIES[randi() % COMBAT_PERSONALITIES.size()]


func create_noncombat_personality() -> String:
	return NONCOMBAT_PERSONALITIES[randi() % NONCOMBAT_PERSONALITIES.size()]


# --- Secondary formulas (baked at generation) ---

func calc_max_health(vitality: int) -> int:
	return (vitality * 12) + 40


func calc_injury_recovery_chance(vitality: int) -> float:
	return float(vitality) / 2.0


func calc_max_stamina(endurance: int) -> int:
	return (endurance * 6) + 20


func calc_stamina_regen(endurance: int) -> float:
	return float(endurance) * 0.25


func calc_fatigue_resistance(endurance: int) -> float:
	return float(endurance) * 0.5


func calc_base_damage(strength: int) -> int:
	return int((float(strength) * 1.5) + 5.0)


func calc_ability_power(strength: int) -> int:
	return strength * 2


func calc_attack_speed(agility: int) -> float:
	return 0.8 + (float(agility) * 0.025)


func calc_dodge_chance(agility: int) -> float:
	return float(agility) * 0.6


func calc_accuracy(precision: int) -> float:
	return 75.0 + (float(precision) * 1.0)


func calc_crit_chance(precision: int) -> float:
	return float(precision) * 0.7


func calc_crit_multiplier(precision: int) -> float:
	return 1.5 + (float(precision) * 0.025)


func calc_crit_defense_factor(resilience: int) -> float:
	## Bonus crit damage is divided by this factor.
	return 1.0 + (float(resilience) * 0.04)


func calc_status_resistance(resilience: int) -> float:
	return float(resilience) * 2.4


func calc_crowd_hype_increment(charisma: int) -> float:
	## Placeholder coefficient; exact value can be tuned later.
	return float(charisma) * 0.8


func calc_intimidation_resistance(charisma: int) -> float:
	return float(charisma) * 1.5


func calc_essence_potency(vitality: int, precision: int, charisma: int) -> float:
	return float(vitality + precision + charisma)


# --- Internal ---

func _weighted_primary_roll() -> int:
	var total_weight := 0.0
	for entry in PRIMARY_WEIGHTS:
		total_weight += float(entry[1])
	var pick := randf() * total_weight
	var cumulative := 0.0
	for entry in PRIMARY_WEIGHTS:
		cumulative += float(entry[1])
		if pick <= cumulative:
			return int(entry[0])
	return 6  # safety fallback (middle of the band)
