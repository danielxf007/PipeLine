extends Node
signal cells_selected(cells)
class_name CellSelector

var matrix_of_cells: Array
var selected_cells: Array = []
var board_m_columns: int

func init(m_columns: int) -> void:
	self.board_m_columns = m_columns
	self.initialize_selected_cells()

func initialize_selected_cells() -> void:
	for _j in range(0, self.board_m_columns-1):
		self.selected_cells.append([])

func in_selected_cells(cell_pos: Tuple) -> int:
	var cell: Cell
	for i in range(0, self.selected_cells[cell_pos.j].size()-1):
		cell = selected_cells[cell_pos.j][i]
		if cell.board_coord.i == cell_pos.i:
			return i
	return -1

func insert_selected_cell(pos: Tuple) -> void:
	var cell: Cell
	var first_cell: Tuple = self.selected_cells[pos.j][0].board_coord
	var last_cell: Cell = self.selected_cells[pos.j][self.selected_cells.size()]
	if first_cell.i > pos.i:
		cell = self.matrix_of_cells[pos.i][pos.j]
		cell.select_this_cell()
		self.selected_cells[pos.j].push_front(cell)
	elif last_cell.i < pos.i:
		cell = self.matrix_of_cells[pos.i][pos.j]
		cell.select_this_cell()
		self.selected_cells[pos.j].append(cell)
	elif first_cell.i < pos.i and last_cell.i > pos.i:
		var cell_to_insert: Cell = self.matrix_of_cells[pos.i][pos.j]
		for index in range(1, self.selected_cells.size()-2):
			cell = self.selected_cells[pos.j][index].board_coord
			if cell.board_coord.i > cell_to_insert.board_coord.i:
				var first_part: Array = self.selected_cells[pos.j].slice(
				0, index-1)
				var second_part: Array = self.selected_cells[pos.j].slice(
				index, self.selected_cells.size()-1)
				cell_to_insert.select_this_cell()
				self.selected_cells[pos.j] = (first_part + [cell_to_insert] +
				second_part)
				break

func eliminate_selected_cell(cell_pos: Tuple, pos_in: int) -> void:
		var cell: Cell = self.matrix_of_cells[cell_pos.i][cell_pos.j]
		cell.deselect_this_cell()
		self.selected_cells[cell_pos.j].remove(pos_in)

func _on_Player_player_selected_cell(pos: Tuple) -> void:
	var pos_in: int = self.in_selected_cells(pos)
	if pos_in == -1:
		self.insert_selected_cell(pos)
	else:
		self.eliminate_selected_cell(pos, pos_in)

func filter_selected_cells() -> void:
	var filtered: Array = []
	for element in self.selected_cells:
		if not element.empty():
			filtered.append(element)
	self.selected_cells = filtered

func reduce_selected_cells() -> void:
	var accumulated: Array = []
	for element in self.selected_cells:
		accumulated += element
	self.selected_cells = accumulated

func deselect_cells() -> void:
	for cell in self.selected_cells:
		cell.deselect_this_cell()

func _on_Button_pressed():
	self.filter_selected_cells()
	self.emit_signal("cells_selected", self.selected_cells)
	self.reduce_selected_cells()
	self.deselect_cells()
	self.selected_cells.clear()
