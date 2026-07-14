# combat/ability_effect.gd
class_name AbilityEffect
extends Resource

@export var name: String = "Basic Attack"
@export var base_damage: int = 20
@export var base_cooldown: float = 1.5
@export var animation: String = "tilt"  # "tilt", "slash", etc. for future AnimationPlayer
@export var sound_stream: AudioStream

# Override this in child classes for special behavior
func execute(user: CharacterToken, target: CharacterToken) -> void:
	if not user or not target:
		return
	apply_damage(user, target)
	play_visuals(user)
	play_sound(user)

func apply_damage(user: CharacterToken, target: CharacterToken, multiplier: float = 1.0) -> void:
	var damage = int(base_damage * multiplier + user.data.strength - target.data.defense * 0.5)
	damage = max(1, damage)
	target.take_damage(damage)
	print("%s used %s on %s for %d damage!" % [user.data.display_name, name, target.data.display_name, damage])

func play_visuals(user: CharacterToken) -> void:
	# Basic tilt for now - we'll improve later
	user.animate_attack()  # We'll add this method to CharacterToken next

func play_sound(user: CharacterToken) -> void:
	if sound_stream and user.has_node("AttackSound"):
		var player = user.get_node("AttackSound") as AudioStreamPlayer
		player.stream = sound_stream
		player.play()
