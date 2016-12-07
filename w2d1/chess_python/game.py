from board import Board
import os

class Game:
	def __init__(self):
		self.board = Board()
		self.player1 = self.board.colors[1]
		self.player2 = self.board.colors[0]
		self.current_player = self.player1

	def format(self, move):
		alphanum1, alphanum2 = move.split(" ")
		pos1 = self.board.alphanum_to_pos(alphanum1)
		pos2 = self.board.alphanum_to_pos(alphanum2)
		return [pos1, pos2]

	def switch_players(self):
		if self.current_player == self.player1:
			self.current_player = self.player2
		else:
			self.current_player = self.player1

	def play(self):
		self.board.render()
		while not self.board.over():
			os.system('clear')
			self.board.render()
			self.take_turn()
			self.switch_players()

	def take_turn(self):
		print self.current_player + '\'s turn. Please enter a start and end position, e.g. \'e2 e4\':'
		print '>',
		pos1, pos2 = self.format(raw_input())
		self.board.move(pos1, pos2)

g = Game()
g.play()
