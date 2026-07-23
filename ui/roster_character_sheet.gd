class_name RosterCharacterSheet
extends Control

## Roster Character Sheet
## Empty template that will be populated once character generation is ready.
## Embed this scene into the Roster tab of Guild_Hub.

@onready var roster_list: VBoxContainer = %RosterList
@onready var empty_state: Control = %EmptyState
@onready var sheet_content: Control = %SheetContent

# Identity
@onready var portrait: TextureRect = %Portrait
@onready var name_label: Label = %NameLabel
@onready var species_label: Label = %SpeciesLabel
@onready var combat_personality_label: Label = %CombatPersonality
@onready var noncombat_personality_label: Label = %NoncombatPersonality
@onready var alive_badge: Label = %AliveBadge

# Vitals
@onready var health_bar: ProgressBar = %HealthBar
@onready var health_value_label: Label = %HealthValue
@onready var stamina_bar: ProgressBar = %StaminaBar
@onready var stamina_value_label: Label = %StaminaValue

# Primary Attributes
@onready var vitality_value: Label = %VitalityValue
@onready var endurance_value: Label = %EnduranceValue
@onready var strength_value: Label = %StrengthValue
@onready var agility_value: Label = %AgilityValue
@onready var precision_value: Label = %PrecisionValue
@onready var resilience_value: Label = %ResilienceValue
@onready var charisma_value: Label = %CharismaValue

# Derived
@onready var max_health_value: Label = %MaxHealthValue
@onready var max_stamina_value: Label = %MaxStaminaValue
@onready var stamina_regen_value: Label = %StaminaRegenValue
@onready var base_damage_value: Label = %BaseDamageValue
@onready var attack_speed_value: Label = %AttackSpeedValue
@onready var initiative_value: Label = %InitiativeValue
@onready var dodge_chance_value: Label = %DodgeChanceValue
@onready var crit_chance_value: Label = %CritChanceValue
@onready var crit_multiplier_value: Label = %CritMultiplierValue
@onready var accuracy_value: Label = %AccuracyValue

# Defense
@onready var primary_dr_value: Label = %PrimaryDRValue
@onready var secondary_crit_def_value: Label = %SecondaryCritDefValue
@onready var status_res_value: Label = %StatusResValue
@onready var intimidation_res_value: Label = %IntimidationResValue

# Stance / Crowd / Meta
@onready var cunning_value: Label = %CunningValue
@onready var cunning_rate_value: Label = %CunningRateValue
@onready var stance_affinity_value: Label = %StanceAffinityValue
@onready var crowd_influence_value: Label = %CrowdInfluenceValue
@onready var essence_potency_value: Label = %EssencePotencyValue

# Abilities
@onready var ability_list: HBoxContainer = %AbilityList

var current_template: CharacterTemplate = null
var roster: Array[CharacterTemplate] = []


func _ready() -> void:
	_show_empty_state()
	# Future: connect to CharacterManager or guild roster signals here


## Call this once character generation / roster loading is implemented.
func set_roster(new_roster: Array[CharacterTemplate]) -> void:
	roster = new_roster
	_rebuild_roster_list()
	if roster.size() > 0:
		select_character(roster[0])
	else:
		_show_empty_state()


func select_character(template: CharacterTemplate) -> void:
	if template == null:
		_show_empty_state()
		return
	current_template = template
	_populate_sheet(template)
	_show_sheet()


func _show_empty_state() -> void:
	empty_state.visible = true
	sheet_content.visible = false
	current_template = null


func _show_sheet() -> void:
	empty_state.visible = false
	sheet_content.visible = true


func _rebuild_roster_list() -> void:
	# Clear existing cards
	for child in roster_list.get_children():
		child.queue_free()

	for template in roster:
		var card := _create_roster_card(template)
		roster_list.add_child(card)

	# Always show empty slots up to a soft max of 5
	var empty_slots := maxi(0, 5 - roster.size())
	for i in empty_slots:
		var empty_card := _create_empty_slot_card()
		roster_list.add_child(empty_card)


func _create_roster_card(template: CharacterTemplate) -> Button:
	var btn := Button.new()
	btn.custom_minimum_size = Vector2(0, 64)
	btn.text = template.display_name if template.display_name != "" else "Unnamed"
	btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
	btn.pressed.connect(select_character.bind(template))
	# Simple visual distinction – can be expanded later with portraits
	if template == current_template:
		btn.modulate = Color(1.15, 1.05, 0.85)
	return btn


func _create_empty_slot_card() -> Button:
	var btn := Button.new()
	btn.custom_minimum_size = Vector2(0, 64)
	btn.text = "+ Empty Slot"
	btn.disabled = true
	btn.modulate = Color(0.6, 0.55, 0.5)
	return btn


func _populate_sheet(t: CharacterTemplate) -> void:
	# Identity
	name_label.text = t.display_name if t.display_name != "" else "Unnamed Gladiator"
	species_label.text = t.species_or_class if t.species_or_class != "" else "Unknown"
	combat_personality_label.text = "Combat: %s" % (t.combat_personality if t.combat_personality != "" else "—")
	noncombat_personality_label.text = "Non-Combat: %s" % (t.noncombat_personality if t.noncombat_personality != "" else "—")
	alive_badge.text = "Alive" if t.is_alive else "Fallen"
	alive_badge.modulate = Color(0.4, 0.85, 0.45) if t.is_alive else Color(0.85, 0.35, 0.3)

	if t.portrait:
		portrait.texture = t.portrait
	elif t.sprite_texture:
		portrait.texture = t.sprite_texture
	else:
		portrait.texture = null

	# Vitals
	var max_hp := maxi(t.base_max_health, 1)
	var cur_hp := clampi(t.current_health, 0, max_hp)
	health_bar.max_value = max_hp
	health_bar.value = cur_hp
	health_value_label.text = "%d / %d" % [cur_hp, max_hp]

	var max_sta := maxi(t.base_max_stamina, 1)
	var cur_sta := clampi(t.current_stamina, 0, max_sta)
	stamina_bar.max_value = max_sta
	stamina_bar.value = cur_sta
	stamina_value_label.text = "%d / %d" % [cur_sta, max_sta]

	# Primary
	_set_stat(vitality_value, t.base_vitality)
	_set_stat(endurance_value, t.base_endurance)
	_set_stat(strength_value, t.base_strength)
	_set_stat(agility_value, t.base_agility)
	_set_stat(precision_value, t.base_precision)
	_set_stat(resilience_value, t.base_resilience)
	_set_stat(charisma_value, t.base_charisma)

	# Derived
	_set_stat(max_health_value, t.base_max_health)
	_set_stat(max_stamina_value, t.base_max_stamina)
	_set_stat(stamina_regen_value, t.base_stamina_regen, "%.1f /s")
	_set_stat(base_damage_value, t.base_damage)
	_set_stat(attack_speed_value, t.base_attack_speed, "%.2f×")
	_set_stat(initiative_value, t.base_initiative, "%.1f")
	_set_stat(dodge_chance_value, t.base_dodge_chance, "%.1f%%")
	_set_stat(crit_chance_value, t.base_crit_chance, "%.1f%%")
	_set_stat(crit_multiplier_value, t.base_crit_multiplier, "%.2f×")
	_set_stat(accuracy_value, t.base_accuracy, "%.0f%%")

	# Defense
	_set_stat(primary_dr_value, t.base_primary_damage_reduction, "%.0f%%")
	_set_stat(secondary_crit_def_value, t.base_secondary_defense_vs_crits, "%.0f%%")
	_set_stat(status_res_value, t.base_status_resistance, "%.0f%%")
	_set_stat(intimidation_res_value, t.base_intimidation_resistance, "%.0f%%")

	# Stance / Crowd / Meta
	_set_stat(cunning_value, t.base_cunning, "%.2f")
	_set_stat(cunning_rate_value, t.base_cunning_rate, "%.2f")
	_set_stat(stance_affinity_value, t.base_stance_affinity, "%.2f")
	_set_stat(crowd_influence_value, t.base_crowd_influence, "%.1f")
	_set_stat(essence_potency_value, t.base_essence_potency, "%.2f")

	# Abilities (clear + rebuild)
	for child in ability_list.get_children():
		child.queue_free()
	if t.abilities.is_empty():
		var placeholder := Label.new()
		placeholder.text = "No abilities assigned yet"
		placeholder.modulate = Color(0.7, 0.65, 0.55)
		ability_list.add_child(placeholder)
	else:
		for ability in t.abilities:
			var card := Label.new()
			card.text = ability.display_name if "display_name" in ability else str(ability)
			card.add_theme_stylebox_override("normal", StyleBoxFlat.new())  # simple visual later
			ability_list.add_child(card)


func _set_stat(label: Label, value: Variant, format: String = "%s") -> void:
	if value == null:
		label.text = "—"
	else:
		label.text = format % value
