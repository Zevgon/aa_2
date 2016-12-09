import itertools
from collections import defaultdict

#O(N^2)
def my_min_phase1(arr):
	for el1 in arr:
		lowest = True
		for el2 in arr:
			if el1 > el2:
				lowest = False
				break
		if lowest:
			return el1
	raise Exception('lol no min hahaha')

#O(N)
def my_min_phase2(arr):
	min = float('inf')
	for el in arr:
		if el < min:
			min = el
	return min

#O(N^3 I think)
def largest_contiguous_subsum_phase1(arr):
	subs = []
	for idx1, el in enumerate(arr):
		idx2 = idx1
		while idx2 < len(arr):
			subs.append(arr[idx1:idx2 + 1])
			idx2 += 1
	max = -float('inf')
	for sub in subs:
		total = 0
		for el in sub:
			total += el
		if total > max:
			max = total
	return max

def largest_contiguous_subsum_phase2(arr):
	maximum = arr[0]
	current_total = maximum
	for idx, el in enumerate(arr):
		if idx == 0:
			continue
		maximum = max([maximum, current_total])
		if el > current_total:
			current_total = max([el, current_total + el])
			maximum = max([maximum, current_total])
		elif el + current_total < 0:
			current_total = el
		else:
			current_total += el
			maximum = max([maximum, current_total])
	return maximum


# print largest_contiguous_subsum_phase2([5, 3, -7])

def include(char, arr):
	for str_char in arr:
		if str_char == char:
			return True
	return False


def anagrams_phase1(str1, str2):
	str2_arr = list(str2)
	perms = itertools.permutations(list(str1))
	for perm in perms:
		if list(perm) == str2_arr:
			return True

	return False

def anagrams_phase2(str1, str2):
	arr1 = list(str1)
	arr2 = list(str2)
	idx = 0
	while idx < len(arr1):
		char = arr1[idx]
		if include(char, arr2):
			arr2_idx = arr2.index(char)
			del(arr2[arr2_idx])
			del(arr1[idx])
			idx -= 1
		idx += 1
	return arr1 == arr2

def anagrams_phase3(str1, str2):
	arr1 = list(str1)
	arr2 = list(str2)
	arr1.sort()
	arr2.sort()
	return arr1 == arr2

def anagrams_phase4(str1, str2):
	dictionary = defaultdict(int)
	for char in str1:
		dictionary[char] += 1
	for char in str2:
		dictionary[char] -= 1
		if dictionary[char] == 0:
			del(dictionary[char])
	return not dictionary
