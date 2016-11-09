#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(arr)
	return 0 if arr.empty?
	return arr[0] if arr.length == 1
	sum_recur(arr[0...-1]) + arr[-1]
end

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(arr, target)
	return false if arr.empty?
	return true if arr[-1] == target
	includes?(arr[0...-1], target)
end

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(arr, target, count = 0)
	return 0 if arr.empty?
	if arr[-1] == target
		count += 1
	end
	count + num_occur(arr[0...-1], target)
end

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(arr)
	return false if arr.length < 2
	return true if arr[0] + arr[1] == 12
	add_to_twelve?(arr[1..-1])
end

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(arr)
	return true if arr.length <= 1
	return false if arr[0] > arr[1]
	sorted?(arr[1..-1])
end

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
	return string if string.length <= 1
	prev = reverse(string[0...-1])
	prev.prepend(string[-1])
end
