extends Node2D
signal player_selected_cell(pos)
signal pipe_line_placed()
class_name Player

var current_button_state: bool = false
var next_button_state: bool = false

func _input(event):
	if $Timer.is_stopped() and event is InputEventScreenTouch:
		self.global_position = event.position
		var pos: Tuple = CoordinateConversor.player_coord_to_board_coord(
		self.global_position)
		self.emit_signal("player_selected_cell", pos)
		$Timer.start()
	if event.is_action_pressed("place_pipe_line"):
		self.emit_signal("pipe_line_placed")
