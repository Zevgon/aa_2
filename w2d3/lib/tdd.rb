require 'set'
def my_uniq(arr)
	seen = Set.new
	result = []
	arr.each do |el|
		result << el unless seen.include?(el)
		seen << el
	end
	result
end

def two_sum(arr, target)
	arr.combination(2).any?{|el| el.reduce(:+) == target}
end

def my_transpose(arr)
	result = Array.new(arr[0].length) {Array.new}
	idx = 0
	while idx < arr[0].length
		arr.each do |row|
			result[idx] << row[idx]
		end
		idx += 1
	end
	result
end

p my_transpose([[1, 2, 3, 4], [5, 6, 7, 8]])
