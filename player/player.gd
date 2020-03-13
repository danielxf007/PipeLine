extends Node2D
signal player_selected_cell(pos)
class_name Player

func _input(event):
	if event is InputEventScreenTouch:
		self.global_position = event.position
		var pos: Tuple = CoordinateConversor.player_coord_to_board_coord(
		self.global_position)
		self.emit_signal("player_selected_cell", pos)
