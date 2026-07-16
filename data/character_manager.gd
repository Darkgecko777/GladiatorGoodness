extends Node

# Export definitions for easy testing in editor
@export var player_definition: CharacterDefinition
@export var enemy_definition: CharacterDefinition

# Create a ready-to-fight token
func create_token(def: CharacterDefinition, is_player: bool = false) -> CharacterToken:
	if not def:
		push_error("CharacterManager: Missing definition!")
		return null
	
	var data = CharacterData.new()
	data.setup_from_definition(def)
	
	var token = preload("res://scenes/Character_Token.tscn").instantiate() as CharacterToken
	token.data = data
	token.is_player_controlled = is_player
	
	return token

# Convenience for battle arena
func create_fight_pair() -> Dictionary:
	return {
		"player": create_token(player_definition, true),
		"enemy": create_token(enemy_definition, false)
	}
