class_name CharacterToken
extends Node2D

@export var data: CharacterData
@export var show_health_bar: bool = true

var health_bar: TextureProgressBar
var sprite: Sprite2D
var attack_sound_player: AudioStreamPlayer

var abilities: Array[Ability] = []

func _ready():
	sprite = get_node_or_null("Sprite2D")
	if data and sprite and data.portrait:
		sprite.texture = data.portrait
			
	setup_health_bar()
	setup_sound_player()
	
	initialize_abilities()
	
	if data:
		data.reset_for_battle()
		
func _process(delta: float):
	if not data or not data.is_alive:
		return
	
	for ability in abilities:
		ability.current_cooldown = max(0, ability.current_cooldown - delta)
		
	if can_auto_attack():
		perform_auto_attack()

func setup_health_bar():
	if not show_health_bar:
		return
		
	if has_node("HealthBar"):
		health_bar = $HealthBar
	else:
		var health_bar_scene = preload("res://ui/HealthBar.tscn")
		health_bar = health_bar_scene.instantiate()
		health_bar.name = "HealthBar"
		add_child(health_bar)
		if has_node("Sprite2D"):
			var sprite = $Sprite2D
			health_bar.position = Vector2(0, -sprite.texture.get_height() / 2)

func update_health_bar():
	if health_bar and data:
		health_bar.max_value = data.max_health
		health_bar.value = data.current_health
	else:
		print("HealthBar not ready for ", name)

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
			update_health_bar()
			return

func find_target() -> CharacterToken:
	var parent = get_parent()
	if data.is_player:
		return parent.get_node_or_null("Minotaur") as CharacterToken
	else: 
		return parent.get_node_or_null("PlayerToken") as CharacterToken
		
func animate_attack():
	if not sprite:
		return
	var original_rot = sprite.rotation_degrees
	var tween = create_tween()
	tween.tween_property(sprite, "rotation_degrees", 30 if data.is_player else -30, 0.08)
	tween.tween_property(sprite, "rotation_degrees", original_rot, 0.15)
	
func take_damage(amount: int):
	if data:
		data.take_damage(amount)
		update_health_bar()
		if not data.is_alive:
			print(data.display_name + " has been defeated!")
	
		
