extends Node


#changes the main players slide speed in relation to speed
func edit_main_stats():
	#gets the main player to change stats
	get_parent().get_parent().slide_multiplier = 4
