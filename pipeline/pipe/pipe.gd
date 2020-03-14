extends Sprite

class_name Pipe

var before_pipe
var next_pipe
var pipe_flux: Liquid
var direction: Vector2 = Vector2(0, 1)
var board_coord: Tuple
var position_on_board: Vector2

func _ready():
	self.set_position_on_board()

func connect_before_pipe(pipe) -> void:
	self.before_pipe = pipe

func connect_next_pipe(pipe) -> void:
	self.next_pipe = pipe

func set_flux(flux: Liquid) -> void:
	if flux:
		self.add_child(flux)
		self.pipe_flux = flux

func rotate_pipe(angle: float) -> void:
	self.direction = self.direction.rotated(angle)
	self.rotate(angle)

func move_to(pos: Tuple) -> void:
	self.global_position.x = pos.j
	self.global_position.y = pos.i

func set_position_on_board() -> void:
	self.global_position = self.position_on_board
