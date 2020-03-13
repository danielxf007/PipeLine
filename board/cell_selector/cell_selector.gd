extends Node

class_name CellSelector

var matrix_of_cells: Array
var player_c: Tuple = Tuple.new(0, 0)
var selected_cells: Array = []

func in_selected_cells(pos: Tuple) -> int:
	if self.selected_cells.empty():
		return -1
	var i: int
	var j: int
	var cell: Cell
	if self.selected_cells.size()%2 == 1:
# warning-ignore:integer_division
		i = self.selected_cells.size()/2 -1
		cell = self.selected_cells[i]
		if UtilFunctions.same_coordinates(cell.board_coord, pos):
			return i
	i = 0
	j = self.selected_cells.size()-1
# warning-ignore:integer_division
	while i < (self.selected_cells.size()/2) -1:
		cell = self.selected_cells[i]
		if UtilFunctions.same_coordinates(cell.board_coord, pos):
			return i
		cell = self.selected_cells[j]
		if UtilFunctions.same_coordinates(cell.board_coord, pos):
			return j
		i += 1
		j -= 1
	return -1

func _on_Player_player_selected_cell(pos: Tuple) -> void:
	var cell: Cell
	var pos_in: int = self.in_selected_cells(pos)
	if pos_in == -1:
		cell = self.matrix_of_cells[pos.i][pos.j]
		if not cell.is_occupied():
			cell.select_this_cell()
			self.selected_cells.append(cell)
	else:
		cell = self.matrix_of_cells[pos.i][pos.j]
		cell.deselect_this_cell()
		self.selected_cells.remove(pos_in)
