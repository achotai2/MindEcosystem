extends Node2D

@export var spawn_tree = preload( "res://Tree.tscn" )
		
func _on_option_pressed():
	if Utils.selected == null:
		# Instantatiate a new tree.
		var oak_tree_material = load( "res://Oak_Tree_Material.tscn" )
		var tree_sprite = oak_tree_material.instantiate()
		var tree = spawn_tree.instantiate()
		tree.add_child( tree_sprite )
		$Trees.add_child( tree )
		
		# Attach signal so that selecting tree will change world mouse selection.
		tree.selection_toggled.connect( _on_tree_toggled )
		
		# Make the tree selected.
		Utils.selected = tree
		tree.get_node( "SelectionArea2D" ).ChangeSelectedState( true )

		# Make the buttons visible.
		$CentralTreeButtons.MakeEmptyVisible()

func _on_tree_toggled( toggled_tree ):
	pass

# THIS FUNCTION IS LIKELY NO LONGER NECCESSARY. CAN PIECE IT OUT.
func ChangeSelection( potential_selection ):
	# Check if anything is selected.
	if potential_selection == null:
		Utils.selected = null

	elif Utils.selected == null:
		Utils.selected = potential_selection
		potential_selection.get_node( "SelectionArea2D" ).ChangeSelectedState( true )

		$CentralTreeButtons.MakeEmptyVisible()

	elif Utils.selected == potential_selection:
		Utils.selected = null
		potential_selection.ChangeSelectedState( false )

		$CentralTreeButtons.MakeAllInvisible()

func _on_button_button_pressed_send_self( button ):
	if Utils.selected != null:
		Utils.selected.position.x = button.global_position.x + ( button.size.x / 2 )
		Utils.selected.position.y = button.global_position.y + ( button.size.y / 2 )

		Utils.selected.get_node( "SelectionArea2D" ).ChangeSelectedState( false )

		Utils.button_chosen = button
		button.ChangeHasTree( true )
		$CentralTreeButtons.MakeAllInvisible()
		
		$Confirm.visible = true
		$Cancel.visible  = true

func _on_confirm_pressed():
	Utils.selected.add_to_group( Utils.button_chosen.name )

	Utils.selected      = null
	Utils.button_chosen = null

	$Confirm.visible = false
	$Cancel.visible  = false

func _on_cancel_pressed():
	if Utils.selected != null:
		Utils.selected.queue_free()
	if Utils.button_chosen != null:
		Utils.button_chosen.ChangeHasTree( false )

	Utils.selected      = null
	Utils.button_chosen = null
		
	$Confirm.visible = false
	$Cancel.visible  = false

# BELOW BUTTON WAS DELETED
func _on_use_plant_pressed():
	if Utils.plantAmount > 0:
		# Decrease amount of plant.
		Utils.plantAmount -= 1

		# Make all trees selectable.
		for tree in $Trees.get_children():
			tree.ChangeSelectableState( true )
