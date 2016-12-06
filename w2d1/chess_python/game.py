from board import Board

class Game:
	def __init__(self):
		self.board = Board()
		self.player1 = board.colors[1]
		self.player2 = board.colors[0]
		self.current_player = self.player1

	def switch_players(self):
		if self.current_player == self.player1:
			self.current_player = self.player2
		else:
			self.current_player = self.player1

	# def play(self):
	#
