extends Node

class_name PipeLinePlacer
export(NodePath) var pipes_path: NodePath
var matrix_of_cells: Array
var pipe_packed_scene: PackedScene = preload("res://pipeline/pipe/pipe.tscn")
var pipe_list: Array = []

func place_pipe_lines(selected_cells: Array) -> void:
	pass

func add_pipe(selected_cells: Array) -> void:
	pass
