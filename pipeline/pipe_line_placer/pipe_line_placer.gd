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
	self.add_pipe_lines(self.pipes_list)
	

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
		if pipe_lines_row[0] == null and pipe_lines_row.size() >= 2:
			pipe_lines_row.pop_front()
			for i in range(1, pipe_lines_row.size()):
				pipe_lines_row[0].concat(pipe_lines_row[i])
			self.pipes_list[j] = [pipe_lines_row[0]]

func add_pipe_lines(pipe_lines_list: Array ) -> void:
	var pipes: Node2D = self.get_node("./"+ self.pipes_path)
	var pipe_lines_row: Array
	for j in range(0, pipe_lines_list.size()):
		pipe_lines_row = pipe_lines_list[j]
		if pipe_lines_row[0] != null:
			if pipes.has_node(str(j)):
				var pipe_line: Node2D = pipes.get_node(str(j))
				pipes.remove_child(pipe_line)
				pipes.add_child(self.create_pipe_line(pipe_lines_row[0],
				str(j)))
			else:
				pipes.add_child(self.create_pipe_line(pipe_lines_row[0],
				 str(j)))

func create_pipe_line(pipe_line: PipeLine, node_name: String) -> Node2D:
	var pipe_line_node: Node2D = Node2D.new()
	pipe_line_node.name = node_name
	var preloaded_pipe = preload("res://pipeline/pipe/pipe.tscn")
	var current_node: Pipe = pipe_line.first_pipe
	var graphical_node: Pipe = preloaded_pipe.instance()
	graphical_node.set_flux(current_node.pipe_flux)
	graphical_node.position_on_board = current_node.position_on_board
	pipe_line_node.add_child(graphical_node)
	while current_node:
		graphical_node = preloaded_pipe.instance()
		graphical_node.set_flux(current_node.pipe_flux)
		graphical_node.position_on_board = current_node.position_on_board
		pipe_line_node.add_child(graphical_node)
		current_node = current_node.next_pipe
	return pipe_line_node
