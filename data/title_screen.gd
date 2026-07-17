extends Control

func _on_play_button_pressed():
	SceneManager.go_to_arena()

func _on_guild_hub_button_pressed():
	SceneManager.go_to_guild_hub()

func _on_options_button_pressed():
	# SceneManager.go_to_options()  # add later
	pass

func _on_quit_button_pressed():
	get_tree().quit()
