extends Sprite

class_name Cell

var element
var dimensions: Tuple
var cell_selected: bool = false
func set_element(new_element) -> void:
	if not self.element:
		self.element = new_element

func clear_element() -> void:
	self.element = null

func is_occupied() -> bool:
	return self.element != null

func select_this_cell() -> void:
	if not self.is_occupied():
		if not self.cell_selected:
			self.self_modulate = "3effffff"
			self.cell_selected = true
		else:
			self.self_modulate = "ffffff"
			self.cell_selected = false
