extends Node

func mantain_in_range(lower_bound, upper_bound, number):
	if number <= lower_bound:
		return lower_bound
	if number >= upper_bound:
		return upper_bound
	return number

func has_reached_upper_bound(upperBound, number) -> bool:
	return number == upperBound

func number_in_range(lower_bound, upper_bound, number) -> bool:
	return lower_bound <= number and number <= upper_bound

func is_inside_matrix(matrix_dim: Tuple, coord: Tuple) -> bool:
	return (self.number_in_range(0, matrix_dim.i-1,
	 coord.i) and self.number_in_range(0, matrix_dim.j-1, coord.j))

func same_coordinates(coord_0: Tuple, coord_1: Tuple) -> bool:
	return coord_0.i == coord_1.i and coord_0.j == coord_1.j
