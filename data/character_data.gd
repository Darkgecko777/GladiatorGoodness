class_name CharacterData
extends Resource

@export var display_name: String = "Gladiator"
@export var portrait: Texture2D
@export var max_health: int = 100
@export var current_health: int = 100
@export var strength: int = 15
@export var defense: int = 8
@export var speed: int = 10

@export var abilities: Array[AbilityData] = []
@export var is_player: bool = true
