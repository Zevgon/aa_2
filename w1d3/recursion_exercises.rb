def range(start, finish)
	return [start] if finish == start
	range(start, finish - 1).push(finish)
end

def sum_iter(arr)
	sum = 0
	arr.each do |el|
		sum += el
	end

	sum
end

def sum_rec(arr)
	return 0 if arr.empty?
	return arr[0] if arr.length == 1
	sum_rec(arr[0...-1]) + arr[-1]
end

def exponentiation1(base, exp)
	return 1 if exp == 0
	exponentiation1(base, exp - 1) * base
end

def exponentiation2(base, exp)
	return 1 if exp == 0
	if exp.even?
		unmultiplied = exponentiation2(base, exp / 2)
		unmultiplied * unmultiplied
	else
		unmultiplied = exponentiation2(base, (exp - 1) / 2)
		unmultiplied * unmultiplied * base
	end
end

class Array
	def deep_dup
		result = []
		each do |el|
			if el.is_a?(Array)
				result << el.deep_dup
			else
				result << el
			end
		end

		result
	end
end

def fibs_rec(n)
	return [] if n == 0
	return [1] if n == 1
	return [1, 1] if n == 2
	prev = fibs_rec(n - 1)
	prev << prev[-1] + prev[-2]
end

def fibs_iter(n)
	return [] if n == 0
	return [1] if n == 1
	arr = [1, 1]
	until arr.length == n
		arr << arr[-1] + arr[-2]
	end

	arr
end

class Array
	def my_permutation
		return [self] if length == 1
		prev = self[0...-1].my_permutation
		nexts = []
		prev.each do |subarr|
			idx = subarr.length
			while idx >= 1
				duped = subarr.dup
				duped.insert(idx, self[-1])
				nexts << duped
				idx -= 1
			end
		end

		prev.each do |subarr|
			duped = subarr.dup
			duped.unshift(self[-1])
			nexts << duped
		end

		nexts
	end
end

class Array
	def bsearch(target)
		return nil if empty?
		half = self.length / 2
		return half if self[half] == target

		left = take(half)
		right = drop(half)

		if target < self[half]
			left.bsearch(target)
		else
			right.bsearch(target) + half
		end
	end

	def merge(other_arr, &prc)
		result = []
		until self.empty? || other_arr.empty?
			if prc.call(self[0], other_arr[0]) < 0
				result << self.shift
			else
				result << other_arr.shift
			end
		end

		result.concat(self).concat(other_arr)
	end

	def merge_sort(&prc)
		prc ||= proc {|x, y| x <=> y}
		return self if length == 1
		left = take(length / 2).merge_sort(&prc)
		right = drop(length / 2).merge_sort(&prc)
		left.merge(right, &prc)
	end

	def subsets
		return [[]] if empty?
		prev = self[0...-1].subsets
		result = []
		prev.each do |el|
			duped = el.dup
			duped << self[-1]
			result << duped
		end

		prev + result
	end
end

def make_better_change(amt, coins)
	return [] if amt == 0
	coins = coins.sort
	best_change = nil
	coins.each.with_index do |coin, idx|
		if coin <= amt
			current_change = make_better_change(amt - coin, coins[0..idx])
			current_change << coin
			best_change ||= current_change
			if current_change.length < best_change.length
				best_change = current_change
			end
		end
	end

	best_change
end

p make_better_change(114, [10, 7, 1])
