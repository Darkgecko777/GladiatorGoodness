extends Control

## Guild Hub controller.
## Wires Market generation to the roster sheet.

const MAX_ROSTER_SIZE := 5

@onready var generator: Node = $GladiatorGenerator
@onready var roster_sheet: RosterCharacterSheet = $MarginContainer/TabContainer/Roster/RosterCharacterSheet
@onready var generate_button: Button = %GenerateGladiatorButton
@onready var market_status: Label = %MarketStatusLabel


func _ready() -> void:
	if generate_button:
		generate_button.pressed.connect(_on_generate_pressed)
	_update_market_status()


func _on_generate_pressed() -> void:
	if generator == null:
		push_error("GuildHub: GladiatorGenerator missing.")
		return
	if roster_sheet == null:
		push_error("GuildHub: RosterCharacterSheet missing.")
		return

	var current := roster_sheet.roster
	if current.size() >= MAX_ROSTER_SIZE:
		if market_status:
			market_status.text = "Roster is full (%d/%d). Release someone first." % [current.size(), MAX_ROSTER_SIZE]
		return

	var gladiator: CharacterTemplate = generator.generate_gladiator()
	if gladiator == null:
		if market_status:
			market_status.text = "Generation failed."
		return

	var new_roster: Array[CharacterTemplate] = []
	new_roster.assign(current)
	new_roster.append(gladiator)
	roster_sheet.set_roster(new_roster)

	if market_status:
		market_status.text = "Recruited %s (%s) — Roster %d/%d" % [
			gladiator.display_name,
			gladiator.character_id,
			new_roster.size(),
			MAX_ROSTER_SIZE
		]

	print("Generated: %s [%s] Cunning %.0f" % [
		gladiator.display_name,
		gladiator.character_id,
		gladiator.base_cunning
	])


func _update_market_status() -> void:
	if market_status == null or roster_sheet == null:
		return
	var count := roster_sheet.roster.size()
	market_status.text = "Roster: %d/%d — Generate adds a random gladiator." % [count, MAX_ROSTER_SIZE]
