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
	print(selected_cells)
	for j in range(0, selected_cells.size()-1):
		cell = selected_cells[j][0]
		pipe = self.pipe_packed_scene.instance()
		cell.set_element(pipe)
		pipe_line = self.pipe_line_scene.instance()
		pipe_line.init(pipe)
		for i in range(1, selected_cells[j].size()-1):
			cell = selected_cells[j][i]
			pipe = self.pipe_packed_scene.instance()
			cell.set_element(pipe)
			pipe_line.connect_to_ending(pipe)
		pipes.add_child(pipe_line)
		pipe_line.global_position = pipe_line.first_pipe.global_position
