extends Node

func MakeAllSelectable( state ):
	for tree in self.get_children():
		tree.get_node( "SelectionArea2D" ).ChangeSelectableState( state )
