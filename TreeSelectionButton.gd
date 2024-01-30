extends Button

signal button_pressed_send_self( button_id )

var has_tree = false

func _ready():
	self.visible = false

func _pressed():
	emit_signal( "button_pressed_send_self", self )

func ChangeHasTree( new_state ):
	self.has_tree = new_state
	
func HasTree():
	return has_tree
