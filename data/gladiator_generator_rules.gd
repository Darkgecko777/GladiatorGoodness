extends Resource

func create_name() -> String:
	return "Bob"
	
func create_stat() -> int:
	var value = randi_range(8,20)
	return value
