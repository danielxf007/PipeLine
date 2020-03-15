extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var board_dim: Tuple
var flux: PackedScene = preload("res://pipeline/liquid/Liquid.tscn")
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
		pipe.set_name("( " + str(cell.board_coord.i) + ", " +
		str(cell.board_coord.j) + " )")
		cell.set_element(pipe)
		pipes.add_child(pipe)
	var ch: Array = pipes.get_children()
	for i in range(0, ch.size()):
		pipe = ch[i]
		print(pipe.name)
		if pipe.before_pipe:
			print(pipe.before_pipe.name)
		if pipe.next_pipe:
			print(pipe.next_pipe.name)
		print("###############################")
