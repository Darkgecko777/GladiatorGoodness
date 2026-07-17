class_name AbilityEffect
extends Resource

@export var base_damage: int = 25
@export var base_cooldown: float = 1.5
@export var is_heal: bool = false

func execute(user: CharacterToken, target: CharacterToken) -> void:
	if is_heal:
		# Future healing logic
		pass
	else:
		apply_damage(user, target)

func apply_damage(user: CharacterToken, target: CharacterToken) -> void:
	if not user.data or not target.data:
		return
	
	# Basic damage using new stats
	var damage = base_damage + user.data.strength * 1.5
	
	# Simple primary mitigation (will be expanded)
	var reduction = target.data.resilience * 0.4  # Placeholder until gear is added
	
	var final_damage = max(1, damage - reduction)
	
	target.take_damage(final_damage)
