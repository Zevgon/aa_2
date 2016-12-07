def positions_in_direction(board, source, towards_coord, lower_bound = 0, upper_bound = 8):
	i_shift = -(source[0] - towards_coord[0])
	j_shift = -(source[1] - towards_coord[1])
	nex = next_pos(source, i_shift, j_shift)
	poses = []
	should_stop = False

	while not should_stop and all(el >= lower_bound and el < upper_bound for el in nex):
		piece1 = board.piece_at(source)
		piece2 = board.piece_at(nex)
		if board.same_colors(piece1, piece2):
			break
		if board.opposite_colors(piece1, piece2):
			should_stop = True
		poses.append(nex)
		nex = next_pos(nex, i_shift, j_shift)

	return poses

def positions_in_direction_including_same_color(board, source, towards_coord, lower_bound = 0, upper_bound = 8):
	i_shift = -(source[0] - towards_coord[0])
	j_shift = -(source[1] - towards_coord[1])
	nex = next_pos(source, i_shift, j_shift)
	poses = []
	should_stop = False

	while not should_stop and all(el >= lower_bound and el < upper_bound for el in nex):
		poses.append(nex)
		if board.occupied(nex):
			should_stop = True
		nex = next_pos(nex, i_shift, j_shift)

	return poses

def next_pos(start_pos, i_shift, j_shift):
	i = start_pos[0]
	j = start_pos[1]
	return [i + i_shift, j + j_shift]

def up_positions(board, source):
	return positions_in_direction(board, source, [source[0] - 1, source[1]])

def down_positions(board, source):
	return positions_in_direction(board, source, [source[0] + 1, source[1]])

def left_positions(board, source):
	return positions_in_direction(board, source, [source[0], source[1] - 1])

def right_positions(board, source):
	return positions_in_direction(board, source, [source[0], source[1] + 1])

def up_right_positions(board, source):
	return positions_in_direction(board, source, [source[0] - 1, source[1] + 1])

def down_right_positions(board, source):
	return positions_in_direction(board, source, [source[0] + 1, source[1] + 1])

def up_left_positions(board, source):
	return positions_in_direction(board, source, [source[0] - 1, source[1] - 1])

def down_left_positions(board, source):
	return positions_in_direction(board, source, [source[0] + 1, source[1] - 1])

def diagonals(board, source):
	return up_left_positions(board, source) + up_right_positions(board, source) + down_left_positions(board, source) + down_right_positions(board, source)

def perpendiculars(board, source):
	return up_positions(board, source) + down_positions(board, source) + left_positions(board, source) + right_positions(board, source)


def up_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0] - 1, source[1]])

def down_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0] + 1, source[1]])

def left_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0], source[1] - 1])

def right_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0], source[1] + 1])

def up_right_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0] - 1, source[1] + 1])

def down_right_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0] + 1, source[1] + 1])

def up_left_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0] - 1, source[1] - 1])

def down_left_positions_including_same_color(board, source):
	return positions_in_direction_including_same_color(board, source, [source[0] + 1, source[1] - 1])

def diagonals_including_same_color(board, source):
	return up_left_positions_including_same_color(board, source) + up_right_positions_including_same_color(board, source) + down_left_positions_including_same_color(board, source) + down_right_positions_including_same_color(board, source)

def perpendiculars_including_same_color(board, source):
	return up_positions_including_same_color(board, source) + down_positions_including_same_color(board, source) + left_positions_including_same_color(board, source) + right_positions_including_same_color(board, source)
