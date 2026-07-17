extends Node

# Current active scene
var current_scene: Node = null

# Preload common scenes if you want faster loading
@export var title_screen: PackedScene
@export var main_arena_scene: PackedScene
@export var guild_hub_scene: PackedScene

func _ready():
	# Make sure this runs first
	process_mode = Node.PROCESS_MODE_ALWAYS

# Change to a new scene
func change_scene(new_scene: PackedScene) -> void:
	if not new_scene:
		push_error("SceneManager: No scene provided!")
		return
	
	# Remove current scene
	if current_scene:
		current_scene.queue_free()
	
	# Instantiate and add new scene
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

# Convenience methods
func go_to_title():
	if title_screen:
		change_scene(title_screen)

func go_to_arena():
	if main_arena_scene:
		change_scene(main_arena_scene)

func go_to_guild_hub():
	if guild_hub_scene:
		change_scene(guild_hub_scene)
