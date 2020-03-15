extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var board_dim: Tuple
var matrix_of_cells: Array
var pipe_packed_scene: PackedScene = preload("res://pipeline/pipe/pipe.tscn")
var pipe_list: Array = []

func place_pipe_lines(selected_cells: Array) -> void:
	var cell: Cell
	var pipes: Node2D = self.get_node("./" + self.pipes_path)
	var pipe: Pipe
	for i in range(0, selected_cells.size()):
		pipe = self.pipe_packed_scene.instance()
		cell = selected_cells[i]
		pipe.init(cell.board_coord, cell.global_position, self.board_dim,
		self.matrix_of_cells)
		pipe.set_name(str(i))
		cell.set_element(pipe)
		pipes.add_child(pipe)

func add_pipe(selected_cells: Array) -> void:
	pass
