extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var pipe_packed_scene: PackedScene = preload("res://pipeline/pipe/pipe.tscn")
var pipe_line_scene: PackedScene = preload("res://pipeline/PipeLine.tscn")

func create_arr_continous_pipes(selected_cells: Array) -> Array:
	var cell: Cell
	var group: Array
	for j in range(0, selected_cells.size()-1):
		for i in range(0, selected_cells[j].size()-1):
			pass
	return []

func place_pipe_lines(selected_cells: Array) -> void:
	var pipe: Pipe
	var pipes: Node2D = self.get_node(self.pipes_path)
	var pipe_line: PipeLine
	for cells in selected_cells:
		pipe_line = self.pipe_line_scene.instance()
		for cell in cells:
			pipe = self.pipe_packed_scene.instance()
			cell.set_element(pipe)
			pipes.add_child(pipe_line)
			pipe_line.global_position = cell.global_position
