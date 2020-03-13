extends Node

class_name CoordinatesConversor
var cell_dim: Tuple

func player_coord_to_board_coord(player_pos: Vector2) -> Tuple:
	var board_coord: Tuple = Tuple.new(
		ceil(player_pos.y/self.cell_dim.i)-1,
		ceil(player_pos.x/self.cell_dim.j)-1)
	return board_coord
