require 'set'

class Node
	attr_reader :val, :parent
	def initialize(val, parent = nil)
		@val = val
		@parent = parent
	end
end

class WordChainer
	def initialize(dictionary = nil)
		@dictionary = dictionary
		@dictionary ||= File.readlines('./dictionary.txt').map(&:chomp)
	end

	def adjacent_words(word)
		@dictionary.select!{|dict_word| dict_word.length == word.length}
		adjes = []
		@dictionary.each do |dict_word|
			adjes << dict_word if adjacent?(dict_word, word)
		end

		adjes
	end

	def adjacent?(word1, word2)
		return false unless word1.length == word2.length
		idx = 0
		count = 0
		while idx < word1.length
			if word1[idx] != word2[idx]
				count += 1
			end
			return false if count > 1
			idx += 1
		end

		count == 1
	end

	def run(start, target)
		unless start.length == target.length
			puts 'Can\'t get there :('
			return
		end
		seen = Set.new
		q = [Node.new(start)]
		found = false
		until q.empty? || found
			adjes = adjacent_words(q[0].val)
			adjes.each do |new_word|
				new_node = Node.new(new_word, q[0])
				if new_word == target
					found = true
					return trace(new_node)
					break
				end
				q << new_node unless seen.include?(new_word)
				seen << new_word
			end
			q.shift
		end

		puts 'Can\'t get there :('
	end

	def trace(node)
		path = []
		while node
			path << node.val
			node = node.parent
		end
		puts path.reverse
	end
end

w = WordChainer.new
w.run('say', 'car')
