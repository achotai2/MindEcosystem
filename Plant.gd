extends StaticBody2D

signal selection_toggled( plant )

# Called when the node enters the scene tree for the first time.
func _ready():
	$SelectionArea2D.ChangeSelectableState( true ) 

func _process(delta):
	# Position follows the mouse cursor if it is selected.
	if $SelectionArea2D.selected:
		position = get_global_mouse_position()

func _on_selection_area_2d_mouse_entered():
	if $SelectionArea2D.selectable:
		$Sprite2D.material.set( "shader_parameter/line_thickness", 1.0 )

func _on_selection_area_2d_mouse_exited():
	if $SelectionArea2D.selectable:
		$Sprite2D.material.set( "shader_parameter/line_thickness", 0.0 )

func _on_selection_area_2d_selection_toggled():
	if $SelectionArea2D.selectable:
		emit_signal( "selection_toggled", self )
