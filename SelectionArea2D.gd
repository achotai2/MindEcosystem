extends Area2D

signal selection_toggled()

var selected   = false
var selectable = false
@export var selection_action = "Select"
	
func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed( selection_action ):
		emit_signal( "selection_toggled" )

func ChangeSelectedState( to_state ):
	self.selected = to_state

func ChangeSelectableState( to_state ):
	self.selectable = to_state
