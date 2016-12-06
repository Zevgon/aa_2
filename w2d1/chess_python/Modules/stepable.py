def adjacent_king_moves(source, lower_bound = 0, upper_bound = 7):
	i = source[0]
	j = source[1]
	adjacents = []
	for i_shift in [-1, 0, 1]:
		for j_shift in [-1, 0, 1]:
			new_pos = [i + i_shift, j + j_shift]
			if (i_shift or j_shift) and (all(between(lower_bound, upper_bound, el) for el in new_pos)):
				adjacents.append(new_pos)
	return adjacents

def adjacent_knight_moves(source, lower_bound = 0, upper_bound = 7):
	i = source[0]
	j = source[1]
	adjacents = []
	for i_shift in [-2, -1, 1, 2]:
		for j_shift in [-2, -1, 1, 2]:
			new_pos = [i + i_shift, j + j_shift]
			if abs(i_shift) != abs(j_shift) and all(between(lower_bound, upper_bound, el) for el in new_pos):
				adjacents.append(new_pos)
	return adjacents

def between(lower_bound, upper_bound, n):
	return n >= lower_bound and n <= upper_bound

def valid_king_moves(board, source):
	valids = []
	for pos in adjacent_king_moves(source):
		if board.different_colors(source, pos):
			valids.append(pos)
	return valids

def valid_knight_moves(board, source):
	valids = []
	for pos in adjacent_knight_moves(source):
		if board.different_colors(source, pos):
			valids.append(pos)
	return valids
