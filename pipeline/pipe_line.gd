extends Node2D
class_name PipeLine

var first_pipe: Pipe
var last_pipe: Pipe

func init(pipe: Pipe) -> void:
	self.first_pipe = pipe
	self.last_pipe = pipe
	self.add_child(pipe)

func connect_to_beginning(pipe: Pipe) -> void:
	if pipe.direction == self.first_pipe.direction:
		self.first_pipe.connect_before_pipe(pipe)
		pipe.connect_next_pipe(self.first_pipe)
		self.add_child_below_node(self, pipe)
		self.first_pipe = pipe
		self.flux_through_pipe_line(self.first_pipe)

func connect_to_ending(pipe: Pipe) -> void:
	if pipe.direction == self.last_pipe.direction:
		self.last_pipe.connect_next_pipe(pipe)
		pipe.connect_before_pipe(self.last_pipe)
		pipe.set_flux(self.last_pipe.pipe_flux)
		self.add_child_below_node(self.last_pipe, pipe)
		self.last_pipe = pipe

func flux_through_pipe_line(start_pipe: Pipe) -> void:
	var current_pipe: Pipe = start_pipe.next_pipe
	while current_pipe != null:
		current_pipe.set_flux(start_pipe.pipe_flux)
		current_pipe = current_pipe.next_pipe

func is_empty() -> bool:
	return self.first_pipe == null and self.last_pipe == null

func concat(pipe_line) -> void:
	self.connect_to_ending(pipe_line.first_pipe)
	self.last_pipe = pipe_line.last_pipe
	self.flux_through_pipe_line(self.last_pipe)

func set_name(new_name: String) -> void:
	self.name = new_name
