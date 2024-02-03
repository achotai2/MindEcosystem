extends Node

func MakeAllSelectable( state ):
	for tree in self.get_children():
		tree.get_node( "SelectionArea2D" ).ChangeSelectableState( state )
		tree.get_node( "Sprite2D" ).material.set( "shader_parameter/line_thickness", 0.0 )
