extends Control

func MakeEmptyVisible():
	for child in self.get_children():
		if not child.HasTree():
			child.visible = true

func MakeAllInvisible():
	for child in self.get_children():
		child.visible = false

func MakeButtonSelectable( treeName ):
	for child in self.get_children():
		if child.has_tree == treeName:
			child.ChangeHasTree( null )
			pass
			
func ChangeButtonHasTree( buttonName, treeName ):
	for child in self.get_children():
		if child.name == buttonName:
			child.ChangeHasTree( treeName )
			pass

func GetButton( treeName ):
	for child in self.get_children():
		if child.has_tree == treeName:
			return child.name

	
