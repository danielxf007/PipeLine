extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var pipe_packed_scene: PackedScene = preload("res://pipeline/pipe/pipe.tscn")
var pipe_line_scene: PackedScene = preload("res://pipeline/PipeLine.tscn")

func place_pipe_lines(selected_cells: Array) -> void:
	var pipe: Pipe
	var pipes: Node2D = self.get_node(self.pipes_path)
	var pipe_lines: PipeLine
	for cell in selected_cells:
		pipe = self.pipe_packed_scene.instance()
		pipe_lines = self.pipe_line_scene.instance()
		pipe_lines.init(pipe)
		cell.set_element(pipe)
		pipes.add_child(pipe_lines)
		pipe_lines.global_position = cell.global_position
