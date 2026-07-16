# data/character_token.gd
class_name CharacterToken
extends Node2D

signal health_changed(new_health: int)
@export var data: CharacterData
@export var is_player_controlled: bool = false  # NEW: Use this instead of data.is_player

var sprite: Sprite2D
var attack_sound_player: AudioStreamPlayer

var abilities: Array[Ability] = []

func _ready():
	sprite = get_node_or_null("Sprite2D")
	
	if data:
		if sprite and data.definition and data.definition.sprite_texture:
			sprite.texture = data.definition.sprite_texture
		data.reset_for_battle()
		data.health_changed.connect(_on_health_changed)
		
	setup_sound_player()
	initialize_abilities()

func _process(delta: float):
	if not data or not data.is_alive:
		return
	
	for ability in abilities:
		ability.current_cooldown = max(0, ability.current_cooldown - delta)
	
	if can_auto_attack():
		perform_auto_attack()

func setup_sound_player():
	attack_sound_player = AudioStreamPlayer.new()
	attack_sound_player.name = "AttackSound"
	add_child(attack_sound_player)

func initialize_abilities():
	abilities.clear()
	if data and data.abilities.size() > 0:
		for ab in data.abilities:
			var new_ability = ab.duplicate()
			abilities.append(new_ability)
	else:
		# Fallback basic attack
		var basic = Ability.new()
		basic.display_name = "Basic Attack"
		var effect = AbilityEffect.new()
		basic.effect = effect
		abilities.append(basic)

func can_auto_attack() -> bool:
	for ability in abilities:
		if ability.is_ready():
			return true
	return false

func perform_auto_attack():
	var target = find_target()
	if not target or not target.data.is_alive:
		return
	
	for ability in abilities:
		if ability.is_ready():
			ability.use(self, target)
			return

func find_target() -> CharacterToken:
	var parent = get_parent()
	for child in parent.get_children():
		if child is CharacterToken and child != self:
			return child
	return null
	
	
func animate_attack():
	if not sprite:
		return
	var original_rot = sprite.rotation_degrees
	var tween = create_tween()
	tween.tween_property(sprite, "rotation_degrees", 30 if is_player_controlled else -30, 0.08)
	tween.tween_property(sprite, "rotation_degrees", original_rot, 0.15)

func take_damage(amount: int):
	if data:
		data.take_damage(amount)
		if not data.is_alive:
			print(data.display_name + " has been defeated!")

func _on_health_changed(new_health: int) -> void:
	pass # Replace with function body.
