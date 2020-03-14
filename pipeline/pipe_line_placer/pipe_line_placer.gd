extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var pipe_packed_scene: PackedScene = preload("res://pipeline/pipe/pipe.tscn")
var pipe_line_scene: PackedScene = preload("res://pipeline/PipeLine.tscn")
var pipes_list: Array = []

func init_pipe_list(m_columns: int) -> void:
	for _j in range(0, m_columns):
		pipes_list.append([null])

func place_pipe_lines(selected_cells: Array) -> void:
	self.set_pipe_list(selected_cells)
	self.reduce_pipe_lines()
	

func set_pipe_list(selected_cells: Array) -> void:
	var pipe: Pipe
	var pipe_line: PipeLine
	var cell: Cell
	var pipe_lines_row: Array
	var pipes_l: Array
	for j in range(0, selected_cells.size()):
		pipe_lines_row = selected_cells[j]
		pipes_l = []
		for i in range(0, pipe_lines_row.size()):
			cell = selected_cells[j][i]
			pipe = self.pipe_packed_scene.instance()
			cell.set_element(pipe)
			pipe.position_on_board = cell.global_position
			pipe_line = self.pipe_line_scene.instance()
			pipe_line.init(pipe)
			pipes_l.append(pipe_line)
		cell = selected_cells[j][0]
		var index = cell.board_coord.j
		self.pipes_list[index] += pipes_l

func reduce_pipe_lines() -> void:
	var pipe_lines_row: Array
	for j in range(0, self.pipes_list.size()):
		pipe_lines_row = self.pipes_list[j]
		if pipe_lines_row[0] == null and pipe_lines_row.size() == 2:
			pipe_lines_row.pop_front()
			for i in range(1, pipe_lines_row.size()):
				pipe_lines_row[0].concat(pipe_lines_row[i])

func add_pipe_lines() -> void:
	var pipes: Node2D = self.get_node("./"+ self.pipes_path)
