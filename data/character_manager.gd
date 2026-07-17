extends Node

# For editor testing / quick battles
@export var player_definition: CharacterDefinition
@export var enemy_definition: CharacterDefinition

# Main roster (persistent)
var guild_roster: Array[PersistentCharacter] = []

func create_token(def: CharacterDefinition, is_player: bool = false) -> CharacterToken:
	if not def:
		push_error("CharacterManager: Missing definition!")
		return null
	
	var data = CharacterData.new()
	data.setup_from_definition(def)
	
	var token_scene = preload("res://scenes/Character_Token.tscn")
	var token = token_scene.instantiate() as CharacterToken
	token.data = data
	token.is_player_controlled = is_player
	
	return token

# New: Create from persistent roster entry
func create_token_from_persistent(persistent: PersistentCharacter, is_player: bool = false) -> CharacterToken:
	if not persistent:
		push_error("CharacterManager: Missing persistent character!")
		return null
	
	var data = persistent.create_runtime_data()
	
	var token_scene = preload("res://scenes/Character_Token.tscn")
	var token = token_scene.instantiate() as CharacterToken
	token.data = data
	token.is_player_controlled = is_player
	
	return token

# Convenience for quick testing
func create_fight_pair() -> Dictionary:
	return {
		"player": create_token(player_definition, true),
		"enemy": create_token(enemy_definition, false)
	}
