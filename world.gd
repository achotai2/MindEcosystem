extends Node2D

@export var spawn_tree = preload( "res://Tree.tscn" )

func SelectTree( tree ):
	Utils.selected = tree
	tree.get_node( "SelectionArea2D" ).ChangeSelectedState( true )

	# Make the buttons visible.
	$CentralTreeButtons.MakeEmptyVisible()
		
func SpawnTree( tree_material ):		
	# Instantatiate a new tree.
	var tree_sprite = tree_material.instantiate()
	var tree = spawn_tree.instantiate()
	tree.add_child( tree_sprite )
	$Trees.add_child( tree )
	
	# Attach signal so that selecting tree will change world mouse selection.
	tree.selection_toggled.connect( _on_tree_toggled )
	
	# Make the tree selected.
	self.SelectTree( tree )
	$Cancel.visible = true
		
func _on_option_pressed():
	if Utils.selected == null:
		var oak_tree_material = load( "res://Oak_Tree_Material.tscn" )
		SpawnTree( oak_tree_material )

func _on_option_2_pressed():
	if Utils.selected == null:
		var oak_tree_material = load( "res://Palm_Tree_Material.tscn" )
		SpawnTree( oak_tree_material )

func _on_option_3_pressed():
	if Utils.selected == null:
		var oak_tree_material = load( "res://Pine_Tree_Material.tscn" )
		SpawnTree( oak_tree_material )

func _on_tree_toggled( toggled_tree ):
	if Utils.selected.get_parent().name == "Plants":
		# Destroy selected plant.
		Utils.selected.queue_free()
		$Plants.remove_child( Utils.selected )
		$Plants.OrganizePlants()

		# Create a blue duplicate tree in spot.
		var blue_tree = toggled_tree.duplicate()
		blue_tree.get_node( "Sprite2D" ).modulate = Color( 0, 0, 0 )
		blue_tree.get_node( "Sprite2D" ).set_material( null )
		self.add_child( blue_tree )
		Utils.plant_moved_tree = blue_tree
		var buttonName =  $CentralTreeButtons.GetButton( toggled_tree.name )
		$CentralTreeButtons.ChangeButtonHasTree( buttonName, blue_tree.name )

		# Select the tree and change the button status.
		$Trees.MakeAllSelectable( false )
#		$Cancel.visible = false
		self.SelectTree( toggled_tree )
		
func _on_button_button_pressed_send_self( button ):
	if Utils.selected != null:
		Utils.selected.position.x = button.global_position.x + ( button.size.x / 2 )
		Utils.selected.position.y = button.global_position.y + ( button.size.y / 2 )

		Utils.selected.get_node( "SelectionArea2D" ).ChangeSelectedState( false )

		Utils.button_chosen = button
		$CentralTreeButtons.MakeAllInvisible()
		
		$Confirm.visible = true
		$Cancel.visible  = true

func _on_confirm_pressed():
	if Utils.plant_moved_tree != null:
		$CentralTreeButtons.MakeButtonSelectable( Utils.plant_moved_tree.name )
		Utils.plant_moved_tree.queue_free()

	$CentralTreeButtons.ChangeButtonHasTree( Utils.button_chosen.name, Utils.selected.name )

	Utils.selected         = null
	Utils.button_chosen    = null
	Utils.plant_moved_tree = null

	$Confirm.visible = false
	$Cancel.visible  = false

func _on_cancel_pressed():	
	if Utils.selected == null:
		pass
	elif Utils.selected.get_parent().name == 'Trees':
		if Utils.plant_moved_tree == null:
			# Delete the tree.
			Utils.selected.queue_free()
		else:
			Utils.selected.position = Utils.plant_moved_tree.position
			var buttonName =  $CentralTreeButtons.GetButton( Utils.plant_moved_tree.name )
			$CentralTreeButtons.ChangeButtonHasTree( buttonName, Utils.selected.name )
			Utils.selected.get_node( "SelectionArea2D" ).ChangeSelectedState( false )
			$Plants.InstantiateNewPlant()
			$Plants.OrganizePlants()
			Utils.plant_moved_tree.queue_free()
			
	elif Utils.selected.get_parent().name == 'Plants':
		Utils.selected.queue_free()
		$Plants.remove_child( Utils.selected )
		$Plants.InstantiateNewPlant()
		$Plants.OrganizePlants()
		$Trees.MakeAllSelectable( false )

	if Utils.button_chosen != null:
		$CentralTreeButtons.ChangeButtonHasTree( Utils.button_chosen.name, null )		

	Utils.selected      = null
	Utils.button_chosen = null
	Utils.plant_moved_tree = null
		
	$Confirm.visible = false
	$Cancel.visible  = false
	$CentralTreeButtons.MakeAllInvisible()
