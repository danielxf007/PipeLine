extends Node2D
signal pipe_line_deleted(new_first_pipe, new_last_pipe)
class_name PipeLine

var first_pipe: Pipe
var last_pipe: Pipe

func _init(pipe: Pipe) -> void:
	self.first_pipe = pipe
	self.last_pipe = pipe

func connect_to_beginning(pipe: Pipe) -> void:
	if pipe.direction == self.first_pipe.direction:
		self.first_pipe.connect_before_pipe(pipe)
		pipe.connect_next_pipe(self.first_pipe)
		self.add_child_below_node(self, pipe)
		self.first_pipe = pipe
		if self.first_pipe.pipe_flux:
			self.flux_through_pipe_line(self.first_pipe.pipe_flux)

func connect_to_ending(pipe: Pipe) -> void:
	if pipe.direction == self.first_pipe.direction:
		self.last_pipe.connect_next_pipe(pipe)
		pipe.connect_before_pipe(self.last_pipe)
		pipe.set_flux(self.last_pipe.pipe_flux)
		self.add_child_below_node(self.last_pipe, pipe)
		self.last_pipe = pipe

func flux_through_pipe_line(flux: Liquid) -> void:
	var current_pipe: Pipe = self.first_pipe.next_pipe
	while current_pipe != null:
		current_pipe.set_flux(flux)
		current_pipe = current_pipe.next_pipe

func is_empty() -> bool:
	return self.first_pipe == null and self.last_pipe == null