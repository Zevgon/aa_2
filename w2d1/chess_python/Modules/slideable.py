def positions_in_direction(board, source, towards_coord, lower_bound = 0, upper_bound = 8):
	i_shift = -(source[0] - towards_coord[0])
	j_shift = -(source[1] - towards_coord[1])
	nex = next_pos(source, i_shift, j_shift)
	all_poses = []
	should_stop = False

	while not should_stop and all(el >= lower_bound and el < upper_bound for el in nex):
		if board.same_colors(source, nex):
			break
		if board.opposite_colors(source, nex):
			should_stop = True
		all_poses.append(nex)
		nex = next_pos(nex, i_shift, j_shift)

	return all_poses

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
