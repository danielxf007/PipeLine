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
	for _j in range(0, self.board_m_columns):
		self.selected_cells.append([])

func in_selected_cells(cell_pos: Tuple) -> int:
	var cell: Cell
	var cell_row: Array = self.selected_cells[cell_pos.j]
	for i in range(0, cell_row.size()):
		cell = cell_row[i]
		if cell.board_coord.i == cell_pos.i:
			return i
	return -1

func insert_selected_cell(pos: Tuple) -> void:
	var cell: Cell
	if selected_cells[pos.j].empty():
		cell = self.matrix_of_cells[pos.i][pos.j]
		cell.select_this_cell()
		self.selected_cells[pos.j].append(cell)
	else:
		var cells_row: Array = self.selected_cells[pos.j]
		var first_cell: Cell = cells_row[0]
		var last_cell: Cell = cells_row[cells_row.size()-1]
		var f_board_coord: Tuple = first_cell.board_coord
		var l_board_cood: Tuple = last_cell.board_coord
		if f_board_coord.i > pos.i:
			cell = self.matrix_of_cells[pos.i][pos.j]
			cell.select_this_cell()
			self.selected_cells[pos.j].push_front(cell)
		elif l_board_cood.i < pos.i:
			cell = self.matrix_of_cells[pos.i][pos.j]
			cell.select_this_cell()
			self.selected_cells[pos.j].append(cell)
		elif f_board_coord.i < pos.i and l_board_cood.i > pos.i:
			var cell_to_insert: Cell = self.matrix_of_cells[pos.i][pos.j]
			var first_part: Array = [first_cell]
			var second_part: Array = [last_cell]
			var index = cells_row.size()-1
			for i in range(1, cells_row.size()-1):
				cell = cells_row[index]
				if cell.board_coord.i > cell_to_insert.board_coord.i:
					index = i
					break
			first_part += cells_row.slice(1, index-1)
			second_part += cells_row.slice(index,cells_row.size()-1)
			cell_to_insert.select_this_cell()
			cells_row = first_part + [cell_to_insert] + second_part
			self.selected_cells[pos.j] = cells_row

func eliminate_selected_cell(cell_pos: Tuple, pos_in: int) -> void:
		var cell: Cell = self.matrix_of_cells[cell_pos.i][cell_pos.j]
		cell.deselect_this_cell()
		self.selected_cells[cell_pos.j].remove(pos_in)

func _on_Player_player_selected_cell(pos: Tuple) -> void:
	if not self.matrix_of_cells[pos.i][pos.j].is_occupied():
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

func belongs_to(group: Array, cell: Cell) -> bool:
	var top_cell: Cell = group[group.size()-1]
	return cell.board_coord.i - top_cell.board_coord.i == 1

func create_groups_of_selected_cells() -> Array:
	var list_of_groups:Array = []
	var groups: Array = []
	var group: Array = []
	var cells_row: Array
	for j in range(0, self.selected_cells.size()):
		groups = []
		cells_row = self.selected_cells[j]
		group.append(self.selected_cells[j][0])
		groups.append(group)
		for i in range(1, cells_row.size()):
			if self.belongs_to(group, cells_row[i]):
				groups[groups.size()-1].append(cells_row[i])
			else:
				group = [cells_row[i]]
				groups.append(group)
		list_of_groups.append(groups)
		group = []
	return list_of_groups

func _on_Player_pipe_line_placed():
	self.filter_selected_cells()
	self.emit_signal("cells_selected",
	self.create_groups_of_selected_cells())
	self.reduce_selected_cells()
	self.deselect_cells()
	self.selected_cells.clear()
	self.initialize_selected_cells()
