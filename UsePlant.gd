extends Button

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "Use plant: " + str( Utils.plantAmount )
