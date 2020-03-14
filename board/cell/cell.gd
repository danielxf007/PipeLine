extends Sprite

class_name Cell

var element
var dimensions: Tuple
var cell_selected: bool = false
var board_coord: Tuple


func set_element(new_element) -> void:
	if not self.element:
		self.element = new_element

func clear_element() -> void:
	self.element.queue_free()
	self.element = null

func is_occupied() -> bool:
	return self.element != null

func select_this_cell() -> void:
	self.self_modulate = "3effffff"

func deselect_this_cell() -> void:
	self.self_modulate = "ffffff"
