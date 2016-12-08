from card import Card
from random import randint


class Deck:
	@classmethod
	def create_deck(self):
		suits = ['spades', 'hearts', 'diamonds', 'clubs']
		vals = {
		  'ace': 14,
		  '2': 2,
		  '3': 3,
		  '4': 4,
		  '5': 5,
		  '6': 6,
		  '7': 7,
		  '8': 8,
		  '9': 9,
		  '10': 10,
		  'jack': 11,
		  'queen': 12,
		  'king': 13
		}
		deck = []
		for suit in suits:
			for val in vals:
				deck.append(Card(suit, val))

		return Deck.shuffle(deck)

	@classmethod
	def shuffle(self, arr):
		for idx in range(len(arr)):
			other_idx = randint(0, len(arr) - 1)
			arr[idx], arr[other_idx] = arr[other_idx], arr[idx]

		return arr

	def __init__(self):
		self.cards = Deck.create_deck()
		self.vals = {
		  'ace': 14,
		  '2': 2,
		  '3': 3,
		  '4': 4,
		  '5': 5,
		  '6': 6,
		  '7': 7,
		  '8': 8,
		  '9': 9,
		  '10': 10,
		  'jack': 11,
		  'queen': 12,
		  'king': 13
		}

	def deal_cards(self, player, num_cards):
		for i in range(num_cards):
			player.cards.append(self.cards.pop())

	def deal_5(self, players):
		if len(players) * 5 > 50:
			return 'Too many players'
		for circle in range(5):
			for player in players:
				self.deal_cards(player, 1)

	def evaluate_hand(self, cards):
		total = 0
		for card in cards:
			total += self.vals[card.val]
		return total

	def take_cards(self, player, inds):
		for idx in reversed(inds):
			self.cards.append(player.cards[idx])
			Deck.shuffle(self.cards)
			del(player.cards[idx])


# d = Deck()
# print map(lambda card: card.val, d.cards)
