extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var pipe_packed_scene: PackedScene = preload("res://pipeline/pipe/pipe.tscn")
var pipe_line_scene: PackedScene = preload("res://pipeline/PipeLine.tscn")


func place_pipe_lines(selected_cells: Array) -> void:
	var pipe: Pipe
	var pipes: Node2D = self.get_node(self.pipes_path)
	var pipe_line: PipeLine
	var cell: Cell
	print_selected(selected_cells)
	for j in range(0, selected_cells.size()):
		cell = selected_cells[j][0]
		pipe = self.pipe_packed_scene.instance()
		cell.set_element(pipe)
		pipe.position_on_board = cell.global_position
		pipe_line = self.pipe_line_scene.instance()
		pipe_line.init(pipe)
		for i in range(1, selected_cells[j].size()):
			cell = selected_cells[j][i]
			pipe = self.pipe_packed_scene.instance()
			cell.set_element(pipe)
			pipe.position_on_board = cell.global_position
			pipe_line.connect_to_ending(pipe)
		pipes.add_child(pipe_line)

func print_selected(selected_cells: Array) -> void:
	for element in selected_cells:
		for cell in element:
			var cell_board: Tuple = cell.board_coord
			print("( " + str(cell_board.i) + ", " + str(cell_board.j) + " )")
		print("##################################")
