extends Node2D
class_name Board
const CELL_X_DIM: float = 48.0
const CELL_Y_DIM: float = 48.0
export(Vector2) var BOARD_TOP_POS: Vector2 = Vector2(24.0, 24.0)
export(int) var NUMBER_OF_CELLS_COLUMNS: int = 22
export(int) var NUMBER_OF_CELLS_ROWS: int = 12
var dimensions: Tuple
var cell_dim: Tuple
var matrix_of_cells: Array
var cell_node: Node2D
var player_c: Tuple = Tuple.new(0, 0)

func _ready():
	self.dimensions = Tuple.new(self.NUMBER_OF_CELLS_ROWS,
	self.NUMBER_OF_CELLS_COLUMNS)
	self.cell_node = $Cells
	self.cell_dim = Tuple.new(self.CELL_Y_DIM, self.CELL_X_DIM)
	self.matrix_of_cells = self.create_matrix(self.BOARD_TOP_POS,
	self.NUMBER_OF_CELLS_ROWS, self.NUMBER_OF_CELLS_COLUMNS,
	self.cell_dim, preload("res://board/cell/Cell.tscn"))
	CoordinateConversor.cell_dim = self.cell_dim

func create_column_cells(starting_point: Vector2, n_cells: int,
 cell_dimensions: Tuple, cell_packed_scene: PackedScene) -> Array:
	var cell: Cell = cell_packed_scene.instance()
	self.cell_node.add_child(cell)
	cell.dimensions = cell_dimensions
	cell.global_position = starting_point
	var cell_column: Array = [cell]
	var before_cell: Cell
	for j in range(1, n_cells):
			cell = cell_packed_scene.instance()
			self.cell_node.add_child(cell)
			cell.dimensions = cell_dimensions
			before_cell = cell_column[j-1]
			cell.global_position.x = (before_cell.position.x +
			before_cell.dimensions.j)
			cell.global_position.y = before_cell.position.y
			cell_column.append(cell)
	return cell_column

func create_matrix(matrix_top_pos: Vector2, n_rows: int, n_columns: int,
cell_dimensions: Tuple, cell_scene: PackedScene) -> Array:
	var matrix: Array = []
	for _i in range(0, n_rows):
		matrix.append(self.create_column_cells(matrix_top_pos, n_columns,
		cell_dimensions, cell_scene))
		matrix_top_pos.y+= cell_dimensions.i
	return matrix

func on_board(coord: Tuple) -> bool:
	return UtilFunctions.is_inside_matrix(self.dimensions, coord)

func _on_Player_player_selected_cell(pos: Tuple) -> void:
	self.matrix_of_cells[pos.i][pos.j].select_this_cell()
