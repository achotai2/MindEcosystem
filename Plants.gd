extends Node

var NUM_PLANT_COLUMNS = 2
var STARTING_X        = 280
var STARTING_Y        = -30
var PLANT_WIDTH       = 50
var PLANT_HEIGHT      = 30

# Called when the node enters the scene tree for the first time.
func _ready():
	var num_plants = self.get_children().size()
	for i in range( Utils.STARTING_PLANT_AMOUNT - num_plants ):
		InstantiateNewPlant()

func InstantiateNewPlant():
	var spawn_plant = load( "res://Plant.tscn" )
	var plant = spawn_plant.instantiate()
	
	# Attach signal so that selecting tree will change world mouse selection.
	plant.selection_toggled.connect( self.get_parent()._on_plant_selection_toggled )

	# Get plants position.
	var num_plants = self.get_children().size()
	var xPos = ( ( num_plants % NUM_PLANT_COLUMNS ) * PLANT_WIDTH ) + STARTING_X
	var yPos = ( int( num_plants / NUM_PLANT_COLUMNS ) * PLANT_HEIGHT ) + STARTING_Y
	plant.global_position.x = xPos
	plant.global_position.y = yPos

	# Attach new child here.
	self.add_child( plant )
	
func OrganizePlants():
	var i = 0
	for plant in self.get_children():
		var xPos = ( ( i % NUM_PLANT_COLUMNS ) * PLANT_WIDTH ) + STARTING_X
		var yPos = ( int( i / NUM_PLANT_COLUMNS ) * PLANT_HEIGHT ) + STARTING_Y
		plant.position.x = xPos
		plant.position.y = yPos
		i += 1
