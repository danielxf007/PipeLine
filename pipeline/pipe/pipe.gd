extends Sprite

class_name Pipe

var before_pipe: Pipe
var next_pipe: Pipe
var pipe_flux: Liquid
var direction: Vector2 = Vector2(1, 0)
var pipe_id: int

func set_id(id: int) -> void:
	self.pipe_id = id

func connect_before_pipe(pipe: Pipe) -> void:
	self.before_pipe = pipe

func connect_next_pipe(pipe: Pipe) -> void:
	self.next_pipe = pipe

func set_flux(flux: Liquid) -> void:
	self.add_child(flux)
	self.pipe_flux = flux

func rotate_pipe(angle: float) -> void:
	self.direction = self.direction.rotated(angle)
	self.rotate(angle)

func move_to(pos: Tuple) -> void:
	self.global_position.x = pos.j
	self.global_position.y = pos.i
