from deck import Deck
from player import Player

class Game:
	def __init__(self, players):
		self.deck = Deck()
		self.players = players
		self.players_still_in = players
		self.pot = 0

	def eliminate_dead_players(self):
		inds = []
		for idx, player in enumerate(self.players_still_in):
			if not player.bank:
				inds.append(idx)
		for idx in reversed(inds):
			del(self.players_still_in[idx])

	def exchange_cards(self):
		for player in self.players:
			print player.name + ', how many cards to exchange?'
			num_cards = raw_input()
			if num_cards:
				self.prompt_cards(player)
			else:
				next

	def pay_winnings(self, winner):
		if not winner:
			return None
		winner.receive_winnings(self.pot)
		self.pot = 0

	def play_game(self):
		while self.players_still_in:
			self.play_round()


	def play_round(self):
		self.deck.deal_5(self.players)
		self.show_all()
		self.take_bets()
		self.exchange_cards()
		self.show_all()
		self.take_bets()
		self.pay_winnings(self.winner())
		self.eliminate_dead_players()

	def prompt_cards(self, player):
		print player.name + ', which cards would you like to exchange? (0-indexed, comma-delimeted)'
		inds = map(lambda el: int(el), raw_input().split(','))
		self.deck.take_cards(player, inds)
		self.deck.deal_cards(player, len(inds))

	def remove_player(self, player):
		player_idx = self.players.index(player)
		del(self.players[player_idx])

	def show_all(self):
		for player in self.players:
			print
			print player.name
			print player.bank
			for card in player.cards:
				print card.to_s()

	def take_bets(self):
		for player in self.players:
			print player.name + ', please make a bet, pass or fold (p for pass, f for fold)'
			res = raw_input()
			if res == 'f':
				self.remove_player(player)
			elif res == 'p':
				next
			else:
				bet_amt = int(res)
				player.bet(bet_amt)
				self.pot += bet_amt

	def winner(self):
		if not self.players:
			return None
		winner = self.players[0]
		high_score = self.deck.evaluate_hand(self.players[0].cards)
		for idx, player in enumerate(self.players):
			if idx == 0:
				next
			score = self.deck.evaluate_hand(player.cards)
			if score > high_score:
				high_score = score
				winner = player
		return winner

players = [Player('Yale'), Player('Bob')]
g = Game(players)
g.play_round()
