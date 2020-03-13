extends Sprite

class_name Cell

var element
var dimensions: Tuple

func set_element(new_element) -> void:
	if not self.element:
		self.element = new_element

func clear_element() -> void:
	self.element = null

func is_occupied() -> bool:
	return self.element != null

func select_this_cell() -> void:
	if not self.is_occupied():
		self.self_modulate = "3effffff"

func player_out_cell() -> void:
	self.self_modulate = "ffffff"
