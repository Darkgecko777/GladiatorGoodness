# combat/ability.gd
class_name Ability
extends Resource

@export var display_name: String = "Slash"
@export var effect: AbilityEffect
@export var cooldown_multiplier: float = 1.0  # e.g. 1.2 for slower heavy attack

# Runtime
var current_cooldown: float = 0.0

func is_ready() -> bool:
	return current_cooldown <= 0.0

func use(user: CharacterToken, target: CharacterToken) -> void:
	if effect and is_ready():
		effect.execute(user, target)
		current_cooldown = effect.base_cooldown * cooldown_multiplier
