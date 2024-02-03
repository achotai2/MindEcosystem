extends Button

signal button_pressed_send_self( button_id )

var has_tree = null

func _ready():
	self.visible = false

func _pressed():
	emit_signal( "button_pressed_send_self", self )

func ChangeHasTree( new_state ):
	self.has_tree = new_state
	
func HasTree():
	if self.has_tree == null:
		return false
	else:
		return true
