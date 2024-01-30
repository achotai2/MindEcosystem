extends Control

func MakeEmptyVisible():
	for child in self.get_children():
		if not child.HasTree():
			child.visible = true

func MakeAllInvisible():
	for child in self.get_children():
		child.visible = false
