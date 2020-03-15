extends Sprite
signal liquid_resource_connected(liquid_resource)
signal before_pipe_connected(pipe)
signal next_pipe_connected(pipe)
signal liquid_flowing(pipe)
class_name Pipe

const NORMAL_DIR: Vector2 = Vector2(0, 1)
var before_pipe
var next_pipe
var pipe_flux_scene: PackedScene = preload("res://pipeline/liquid/Liquid.tscn")
var pipe_flux: Liquid
var direction: Vector2 = Vector2(0, 1)
var board_coord: Tuple
var position_on_board: Vector2
var board_dim: Tuple
var matrix_of_cells: Array

func init(board_pos: Tuple, world_pos: Vector2, board_di: Tuple,
matrix: Array) -> void:
	self.board_coord = board_pos
	self.position_on_board = world_pos
	self.board_dim = board_di
	self.matrix_of_cells = matrix

func set_pipe() -> void:
	if self.there_is_next_pipe(self.board_coord.i, self.board_coord.j,
	self.direction):
		self.connect_next_pipe(self.board_coord.i, self.board_coord.j,
		self.direction)
		self.emit_signal("next_pipe_connected")
	if self.there_is_before_pipe(self.board_coord.i, self.board_coord.j,
	self.direction):
		self.connect_before_pipe(self.board_coord.i, self.board_coord.j,
		self.direction)
		self.emit_signal("before_pipe_connected")

func _ready():
	self.set_position_on_board()
	self.set_pipe()

func there_is_before_pipe(i: int, j: int, dir: Vector2) -> bool:
	if UtilFunctions.number_in_range(0, self.board_dim.i-1, 
	i - dir.y) and UtilFunctions.number_in_range(0,
	self.board_dim.j, j - dir.x):
		return self.matrix_of_cells[i - dir.y][j - dir.x].is_occupied()
	return false

func connect_before_pipe(i: int, j: int, dir: Vector2) -> void:
	var cell: Cell = self.matrix_of_cells[i - dir.y][j - dir.x]
	var pipe: Pipe = cell.element
# warning-ignore:return_value_discarded
	pipe.connect("next_pipe_connected", self, "_on_pipe_next_pipe_connected")
# warning-ignore:return_value_discarded
	self.connect("liquid_flowing", pipe, "_on_pipe_liquid_flowing")

func there_is_next_pipe(i: int, j: int, dir: Vector2) -> bool:
	if UtilFunctions.number_in_range(0, self.board_dim.i-1, 
	i + dir.y) and UtilFunctions.number_in_range(0,
	self.board_dim.j-1, j + dir.x):
		return self.matrix_of_cells[i + dir.y][j + dir.x].is_occupied()
	return false

func connect_next_pipe(i: int, j: int, dir: Vector2) -> void:
	var cell: Cell = self.matrix_of_cells[i + dir.y][j + dir.x]
	var pipe: Pipe = cell.element
# warning-ignore:return_value_discarded
	pipe.connect("before_pipe_connected", self,
	"_on_pipe_before_pipe_connected")
# warning-ignore:return_value_discarded
	pipe.connect("liquid_flowing", self, "_on_pipe_liquid_flowing")

func has_flux() -> bool:
	if self.pipe_flux == null:
		return false
	return true

func set_position_on_board() -> void:
	self.global_position = self.position_on_board

func _on_pipe_before_pipe_connected(pipe):
	self.before_pipe = pipe
	if pipe.has_flux():
		var flux: Liquid = self.pipe_flux_scene.instance()
		flux._init(pipe.pipe_flux.liquid_name)
		self.add_child(flux)
		self.pipe_flux = flux
		self.emit_signal("liquid_flowing", self)

func _on_pipe_next_pipe_connected(pipe):
	self.next_pipe = pipe

func _on_pipe_liquid_flowing(pipe):
		var flux: Liquid = self.pipe_flux_scene.instance()
		flux._init(pipe.pipe_flux.liquid_name)
		self.add_child(flux)
		self.pipe_flux = flux
		self.emit_signal("liquid_flowing", self)

func _on_pipe_liquid_resource_connected(liquid_resource):
	self.pipe_flux = liquid_resource.liquid

func set_name(new_name: String) -> void:
	self.name = new_name
